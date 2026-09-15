#!/usr/bin/env python3
"""
Lightweight, zero-install JIT PDF reader for academic papers using pypdf via uv.
Usage:
  uv run --with pypdf python3 extract_pdf.py --pdf path/to/paper.pdf --mode toc
  uv run --with pypdf python3 extract_pdf.py --pdf path/to/paper.pdf --mode section --pages 3-5
"""

import argparse
import json
import sys
from pathlib import Path

def extract_toc(pdf_path: Path):
    from pypdf import PdfReader
    reader = PdfReader(str(pdf_path))
    num_pages = len(reader.pages)
    
    outlines = []
    try:
        outline = reader.outline
        def parse_outline(items, depth=0):
            for item in items:
                if isinstance(item, list):
                    parse_outline(item, depth + 1)
                else:
                    title = getattr(item, "title", str(item))
                    page = reader.get_destination_page_number(item) + 1 if hasattr(item, "page") else "N/A"
                    outlines.append({"depth": depth, "title": title, "page": page})
        if outline:
            parse_outline(outline)
    except Exception:
        pass
    
    first_page_text = reader.pages[0].extract_text() if num_pages > 0 else ""
    
    result = {
        "file": str(pdf_path),
        "total_pages": num_pages,
        "outline": outlines,
        "first_page_preview": first_page_text[:1200]
    }
    print(json.dumps(result, indent=2))

def extract_pages(pdf_path: Path, start_page: int, end_page: int):
    from pypdf import PdfReader
    reader = PdfReader(str(pdf_path))
    total = len(reader.pages)
    
    start_idx = max(0, start_page - 1)
    end_idx = min(total, end_page)
    
    content = []
    for idx in range(start_idx, end_idx):
        text = reader.pages[idx].extract_text() or ""
        content.append(f"--- Page {idx + 1} of {total} ---\n{text.strip()}\n")
    
    print("\n".join(content))

def main():
    parser = argparse.ArgumentParser(description="JIT Token-Efficient PDF Reader")
    parser.add_argument("--pdf", required=True, type=Path, help="Path to PDF file")
    parser.add_argument("--mode", choices=["toc", "section"], required=True, help="Extraction mode")
    parser.add_argument("--pages", type=str, default="1-1", help="Page range for section mode (e.g. 3-5)")
    
    args = parser.parse_args()
    if not args.pdf.exists():
        sys.exit(f"Error: PDF file {args.pdf} not found")
        
    if args.mode == "toc":
        extract_toc(args.pdf)
    elif args.mode == "section":
        parts = args.pages.split("-")
        start = int(parts[0])
        end = int(parts[1]) if len(parts) > 1 else start
        extract_pages(args.pdf, start, end)

if __name__ == "__main__":
    main()
