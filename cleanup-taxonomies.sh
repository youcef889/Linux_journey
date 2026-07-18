#!/bin/bash
# scripts/cleanup-taxonomies.sh

CONTENT_DIR="content"
TAXONOMY_DIR="data/taxonomies"

echo "=== Taxonomy Cleanup Report ==="
echo ""

# Find all tags used in content
echo "Tags actually used in content:"
grep -rh "^tags:" "$CONTENT_DIR" | sed 's/tags://g' | tr ',' '\n' | sed 's/^[ \t]*//;s/[ \t]*$//' | sort -u | tee /tmp/used_tags.txt
USED_TAGS=$(wc -l < /tmp/used_tags.txt)

echo ""
echo "Total tags in site: 99"
echo "Tags used in content: $USED_TAGS"
echo "Orphan tags to remove: $((99 - USED_TAGS))"
echo ""

# Find all categories used in content
echo "Categories actually used in content:"
grep -rh "^categories:" "$CONTENT_DIR" | sed 's/categories://g' | tr ',' '\n' | sed 's/^[ \t]*//;s/[ \t]*$//' | sort -u | tee /tmp/used_categories.txt
USED_CATS=$(wc -l < /tmp/used_categories.txt)

echo ""
echo "Total categories in site: 38"
echo "Categories used in content: $USED_CATS"
echo ""

# Recommend tag merges
echo "=== Recommended Tag Merges ==="
echo "linux + linux-basics + linux-kernel -> linux"
echo "how-to + guide + tutorial -> tutorial"
echo "network + networking -> networking"
echo "sound + audio -> audio"
echo "virtualization + vm + qemu + kvm -> virtualization"
echo ""
echo "=== Tags to Remove (unused) ==="
comm -23 <(ls content/tags/ 2>/dev/null | sort) <(cat /tmp/used_tags.txt | sort) 2>/dev/null || echo "Run this after reviewing used tags"
