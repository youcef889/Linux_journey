+++
title = "LaTeX Arabic Documents - XeLaTeX and Polyglossia Guide"
date = "2026-03-18T16:06:37+01:00"
draft = true
description = "Learn how to create Arabic documents with LaTeX using XeLaTeX and polyglossia. Structure, fonts, and bidirectional text support."
summary = "Guide to creating Arabic documents with LaTeX. Covers XeLaTeX setup, polyglossia configuration, Arabic fonts, and bidirectional text."
slug = "latex-arabic-documents"
categories = ["LaTeX", "Documentation", "Arabic"]
tags = ["latex", "arabic", "xelatex", "polyglossia", "documentation"]
keywords = ["latex arabic", "arabic latex", "xelatex arabic", "arabic document"]
+++


Great! If you're making a **book** with Arabic content using **XeLaTeX** and **polyglossia**, here’s how you can structure it properly and ensure everything works smoothly.

---

## 1️⃣ Basic Setup for a Book

Start with a **book** class, which is suited for long documents with chapters, sections, etc.

```latex
\documentclass[12pt, oneside]{book}

\usepackage{fontspec}
\usepackage{polyglossia}

% Set the main language to Arabic
\setmainlanguage{arabic}

% Set other languages (e.g., English)
\setotherlanguage{english}

% Define Arabic font (Amiri is commonly used)
\newfontfamily\arabicfont[Script=Arabic]{Amiri}

\begin{document}

% Title page
\title{عنوان الكتاب}
\author{اسم المؤلف}
\date{\today}
\maketitle

\chapter{المقدمة}
هذا هو الكتاب التجريبي.

\chapter{الفصل الأول}
هنا نكتب نص عربي.

\section{القسم الأول}
نحن نقوم بكتابة الأقسام والمواضيع باللغة العربية.

\textenglish{This is some English text inside the Arabic document.}

\end{document}
```

### Key Points:

1. **Book Class**: `\documentclass[12pt]{book}` – This is better for larger documents like books (supports chapters, etc.).
2. **Arabic Font**: We're using `Amiri` font (you can change this to any Arabic font you prefer).
3. **Language Switch**: Using `polyglossia` to set Arabic as the main language, and English as a secondary language.
4. **Title Page**: We define a title, author, and date.

---

## 2️⃣ Organizing Chapters

For a book, you’ll want multiple chapters and sections. Each chapter should be defined using `\chapter`, and inside that, you can have sections and subsections.

### Example: Arabic Book with Multiple Chapters

```latex
\documentclass[12pt, oneside]{book}

\usepackage{fontspec}
\usepackage{polyglossia}

\setmainlanguage{arabic}
\setotherlanguage{english}

\newfontfamily\arabicfont[Script=Arabic]{Amiri}

\begin{document}

\title{دليل تعلم البرمجة}
\author{أحمد علي}
\date{\today}
\maketitle

\chapter{المقدمة}
البرمجة هي مهارة أساسية في العصر الحديث، ومن المهم تعلمها...

\chapter{الفصل الأول: أساسيات البرمجة}
في هذا الفصل، سنتناول الأساسيات التي تحتاج إلى معرفتها.

\section{اللغة الأولى: بايثون}
تعتبر لغة بايثون من أفضل اللغات للمبتدئين...

\textenglish{Python is easy to learn and great for beginners.}

\chapter{الفصل الثاني: تقنيات متقدمة}
في هذا الفصل، سنتعلم تقنيات متقدمة في البرمجة...

\end{document}
```

### Features:

1. **Chapters**: `\chapter{}` defines chapters.
2. **Sections**: `\section{}` and `\subsection{}` organize the content.
3. **English Inside Arabic**: You can use `\textenglish{}` to write in English inside Arabic text.
4. **Page Style**: With `book` class, you automatically get the standard chapter headings and page numbers for book formatting.

---

## 3️⃣ Handling Arabic Page Numbers

You can set Arabic-style page numbers (e.g., "١, ٢, ٣") by doing:

```latex
\usepackage{arabxetex}
\renewcommand{\thepage}{\arabic{page}}  % Use Arabic numbers for page numbering
```

However, **XeLaTeX** usually handles the page numbers correctly for Arabic documents by default.

---

## 4️⃣ Adding a Table of Contents

To generate a table of contents (TOC), simply use:

```latex
\tableofcontents
```

This will automatically list all the chapters, sections, and subsections in your book.

---

## 5️⃣ Styling Chapters (Optional)

You can customize the chapter headings or add additional formatting like:

```latex
\usepackage{titlesec}

\titleformat{\chapter}[block]{\huge\bfseries}{\thechapter}{1em}{}
```

This makes your chapter numbers bold and larger.

---

## 6️⃣ Adding Arabic Index and Glossary

If you want to add an index or glossary in Arabic:

```latex
\usepackage{makeidx}
\makeindex

% Use Arabic for index
\renewcommand{\indexname}{فهرس}

\begin{document}

% Index entries
\index{برمجة}
\index{Python}

% Add the index
\printindex

\end{document}
```

---

## 7️⃣ Handling Arabic Paragraphs

Write your paragraphs in Arabic, and **XeLaTeX** will handle the line breaks and paragraph alignment automatically.

```latex
هذا نص تجريبي يظهر كيفية تنسيق الفقرات بشكل صحيح باستخدام XeLaTeX.
```

You don’t need any extra code for line breaks, but if you want a new paragraph, simply leave a blank line.

---

## 8️⃣ Final Template Example

Here's a full example for a small Arabic book:

```latex
\documentclass[12pt, oneside]{book}

\usepackage{fontspec}
\usepackage{polyglossia}

\setmainlanguage{arabic}
\setotherlanguage{english}

\newfontfamily\arabicfont[Script=Arabic]{Amiri}

\begin{document}

\title{دليل تعلم البرمجة}
\author{أحمد علي}
\date{\today}
\maketitle

\tableofcontents

\chapter{المقدمة}
البرمجة هي مهارة أساسية في العصر الحديث، ومن المهم تعلمها...

\chapter{الفصل الأول: أساسيات البرمجة}
في هذا الفصل، سنتناول الأساسيات التي تحتاج إلى معرفتها.

\section{اللغة الأولى: بايثون}
تعتبر لغة بايثون من أفضل اللغات للمبتدئين...

\textenglish{Python is easy to learn and great for beginners.}

\chapter{الفصل الثاني: تقنيات متقدمة}
في هذا الفصل، سنتعلم تقنيات متقدمة في البرمجة...

\end{document}
```

---

## 9️⃣ Compiling your Book

1. **On Overleaf**: Make sure to select **XeLaTeX** as your compiler.
2. **Locally**: Run the following command in your terminal:

   ```bash
   xelatex mybook.tex
   ```

You may need to run it twice if you're using a Table of Contents.

---

Let me know if you need help with:

* **Font Choices** (like Noto Arabic or Scheherazade)
* **Custom Chapter Styles**
* **Adding more complex content** (like images, footnotes, etc.)

I’m happy to assist further! 👌

