
for /F "tokens=*" %%1 in ('wevtutil.exe el') do wevtutil.exe cl "%%1"
