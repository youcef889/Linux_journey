const SHEET_ID = '1mPxSYee9sDgc4MR4mrrRMHsm6gJVb5iV1yL5IfBRW5Q';
const SHEET = 'Emails';
const HEADERS = ['Date', 'Email', 'Page'];
const TOKEN_PREFIX = 'newsletter_token_';
const TOKEN_TTL_MS = 10 * 60 * 1000;

function doGet(e) {
  const params = e && e.parameter ? e.parameter : {};
  const callback = params.callback || '';

  if (params.action !== 'status') {
    return output({ status: 'error', message: 'Unsupported action.' }, callback);
  }

  return output(readStatus(params.token), callback);
}

function doPost(e) {
  const params = e && e.parameter ? e.parameter : {};
  const callback = params.callback || '';
  const value = normalizeToken(params.token);

  if (!value) {
    return output({ status: 'error', message: 'Invalid request.' }, callback);
  }

  let result;
  try {
    cleanupExpiredTokens();

    if (params.website) {
      result = { status: 'spam', message: 'Thanks for your interest.' };
    } else {
      const email = normalizeEmail(params.email);
      if (!email) {
        result = { status: 'invalid', message: 'Please enter a valid email address.' };
      } else {
        result = subscribe(email, sanitizePage(params.page));
      }
    }
  } catch (error) {
    console.error('Newsletter subscription failed', error);
    result = { status: 'error', message: 'The newsletter service is unavailable. Please try again.' };
  }

  writeStatus(value, result);
  return output(result, callback);
}

function subscribe(email, page) {
  const spreadsheet = SpreadsheetApp.openById(SHEET_ID);
  const lock = LockService.getScriptLock();

  if (!lock.tryLock(10000) || !lock.hasLock()) {
    return { status: 'busy', message: 'The newsletter service is busy. Please try again.' };
  }

  try {
    const sheet = ensureSheet(spreadsheet);

    if (emailExists(sheet, email)) {
      return { status: 'duplicate', message: 'This email is already subscribed.' };
    }

    sheet.appendRow([new Date(), email, page]);
    return { status: 'success', message: 'Thanks! You are subscribed.' };
  } finally {
    lock.releaseLock();
  }
}

function ensureSheet(spreadsheet) {
  let sheet = spreadsheet.getSheetByName(SHEET);
  if (!sheet) sheet = spreadsheet.insertSheet(SHEET);

  const lastRow = sheet.getLastRow();
  const current = sheet.getRange(1, 1, 1, HEADERS.length).getValues()[0];
  const hasHeaders = HEADERS.every(function (header, index) {
    return String(current[index] || '').trim().toLowerCase() === header.toLowerCase();
  });

  if (lastRow === 0) {
    sheet.getRange(1, 1, 1, HEADERS.length).setValues([HEADERS]);
  } else if (!hasHeaders) {
    sheet.insertRowBefore(1);
    sheet.getRange(1, 1, 1, HEADERS.length).setValues([HEADERS]);
  }

  return sheet;
}

function emailExists(sheet, email) {
  const lastRow = sheet.getLastRow();
  if (lastRow < 2) return false;

  const values = sheet.getRange(2, 2, lastRow - 1, 1).getValues();
  return values.some(function (row) {
    return String(row[0] || '').trim().toLowerCase() === email;
  });
}

function normalizeEmail(value) {
  const email = String(value == null ? '' : value).trim().toLowerCase();
  if (email.length > 254) return '';
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(email)) return '';
  return email;
}

function sanitizePage(value) {
  const page = String(value == null ? '' : value).trim();
  if (!/^\/[^\s]*$/.test(page)) return '';
  return page.slice(0, 500);
}

function normalizeToken(value) {
  const token = String(value == null ? '' : value).trim().toLowerCase();
  return /^[a-f0-9]{16,64}$/.test(token) ? token : '';
}

function writeStatus(value, result) {
  try {
    PropertiesService.getScriptProperties().setProperty(
      TOKEN_PREFIX + value,
      JSON.stringify({
        status: result.status,
        message: result.message || '',
        expires: Date.now() + TOKEN_TTL_MS
      })
    );
  } catch (error) {
    console.error('Unable to store newsletter status', error);
  }
}

function readStatus(value) {
  const token = normalizeToken(value);
  if (!token) return { status: 'error', message: 'Invalid request.' };

  const properties = PropertiesService.getScriptProperties();
  const key = TOKEN_PREFIX + token;
  const raw = properties.getProperty(key);
  if (!raw) return { status: 'pending', message: '' };

  let stored;
  try {
    stored = JSON.parse(raw);
  } catch (error) {
    properties.deleteProperty(key);
    return { status: 'error', message: 'Please try again.' };
  }

  if (!stored || !stored.expires || stored.expires < Date.now()) {
    properties.deleteProperty(key);
    return { status: 'error', message: 'This confirmation expired. Please try again.' };
  }

  return { status: stored.status, message: stored.message || '' };
}

function cleanupExpiredTokens() {
  const properties = PropertiesService.getScriptProperties();
  const now = Date.now();
  const keys = properties.getKeys().filter(function (key) {
    return key.indexOf(TOKEN_PREFIX) === 0;
  });

  keys.forEach(function (key) {
    let stored = null;
    try {
      stored = JSON.parse(properties.getProperty(key));
    } catch (error) {
      stored = null;
    }
    if (!stored || !stored.expires || stored.expires < now) {
      properties.deleteProperty(key);
    }
  });
}

function output(payload, callback) {
  const body = JSON.stringify(payload).replace(/</g, '\\u003c');
  const name = String(callback || '');

  if (name && /^[A-Za-z_$][A-Za-z0-9_$]*$/.test(name)) {
    return ContentService.createTextOutput(name + '(' + body + ');')
      .setMimeType(ContentService.MimeType.JAVASCRIPT);
  }

  return ContentService.createTextOutput(body)
    .setMimeType(ContentService.MimeType.JSON);
}
