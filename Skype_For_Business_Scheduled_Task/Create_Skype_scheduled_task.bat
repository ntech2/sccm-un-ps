schtasks /Create /SC MINUTE /MO 15 /RU %user1% /IT /TN StartSkype /TR "wscript C:\Windows\LDz\StartSkype.vbs"
