# Flutter Mobile using Provider
## Getting Started!
1. เปิดโปรเจกต์ใน Text Editor เช่น IntelliJ IDEA, Android Studio หรือ VS Code
2. ติดตั้ง Android Emulator (แนะนำเป็นของ Android Studio หรือ Genymotion)
3. ใช้ Server สำหรับเรียกข้อมูลโดยใช้ของ โปรเจกต์ CA2019
	- ถ้ารันโปรเจกต์ CA2019 ได้ โมบายแอป ก็จะสามารถรับ-ส่ง API ได้ จาก Package MS (Micro Service)
4. แก้ไขไฟล์ global.dart เปลี่ยน url ของตัวแปร `BASE_API_URL` และ `URL_HOST_SERVER` เป็น IPv4 Address ของเครื่อง
	- การหา IPv4 Address ให้เข้า Command Prompt ของเครื่อง พิมคำว่า `ipconfig` แล้วหา IPv4 Address ในหัวข้อ Wireless LAN adapter Wi-Fi:
	
![command line](https://192.168.5.64/svn/flutter_mobile/!svn/ver/9/trunk/ipconfigImg.PNG?raw=true)

### Function
Function on 06-Oct-2020
- Log in-out
- Check in-out
- Check in-out late
- Show Article List
- Show Article Details
- Show Ticket List
- Add Ticket List


### Environment
Environment on 06-Oct-2020
- SDK Android API 28-29 (Stable)
- Flutter (Channel master, 1.21.0-10.0.pre.193, on Microsoft Windows [Version 10.0.19041.572], locale en-US)
- Framework • revision d9188c19f6 (3 months ago) • 2020-08-20 01:41:04 -0400
- Engine • revision 81027ab0cc
- Tools • Dart 2.10.0 (build 2.10.0-45.0.dev)
- Android toolchain - develop for Android devices (Android SDK version 30.0.2)
