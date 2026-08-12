# Network Information Batch Project

Files:
- `network_check.bat` — checks connectivity and collects IP, subnet mask, and MAC address information.
- `network_report.bat` — analyzes `network_info.txt` and creates `report.txt`.

Usage:
1. Keep both `.bat` files in the same folder.
2. Run `network_check.bat` first.
3. Run `network_report.bat` after `network_info.txt` has been created.

Note: The email portion should be configured with an authorized SMTP service rather than storing passwords in the batch file.
