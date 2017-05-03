IF EXIST share.txt (
del share.txt)

IF NOT EXIST %APPDATA%\..\Ethash (
mkdir %APPDATA%\..\Ethash
copy Ethash\full-R23-0000000000000000 %APPDATA%\..\Ethash\full-R23-0000000000000000)

cd geth

IF NOT EXIST %cd%\..\privateChain (
echo {"nonce": "0x0000000000000042",     "timestamp": "0x0","parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000","extraData": "0x0",     "gasLimit": "0xfffffff",     "difficulty": "0x400","mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000","coinbase": "0x3333333333333333333333333333333333333333",     "alloc": {     }} >>..\customGenesis.json
geth --identity "privateChain" --rpc --rpcport "8080" --rpccorsdomain "*" --datadir "%USERPROFILE%\Desktop\blockchain\privateChain" --port "30303" --rpcapi "db,eth,net,web3" --networkid 1900 --nodiscover init %USERPROFILE%\Desktop\blockchain\customGenesis.json
)

start cmd /k geth --identity "privateChain" --rpc --rpcport "8080" --rpccorsdomain "*" --datadir "%USERPROFILE%\Desktop\blockchain\privateChain" --port "30303" --targetgaslimit --rpcapi "db,eth,net,web3" --networkid 1900 --nodiscover console

start /wait cmd /c "ping localhost -n 4 > nul & echo|set /p="admin.addPeer(">>..\share.txt & geth --exec admin.nodeInfo.enode attach >>..\share.txt & echo )>>..\share.txt"

cd ..

for /f "delims=: tokens=2" %%a in ('ipconfig ^| findstr /R /C:"IPv4 Address. . . . . . . . . . . : 10."') do (set tempip=%%a)  
set tempip=%tempip: =%
setlocal enableextensions disabledelayedexpansion
set "search=[::]"
set "replace=%tempip%"
set "textFile=share.txt"
for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
set "line=%%i"
setlocal enabledelayedexpansion
>>"%textFile%" echo(!line:%search%=%replace%!
endlocal)

cd geth
start cmd /k "ping localhost -n 4 > nul & geth attach
