cd contents
mkdir %USERPROFILE%\Desktop\Blockchain
robocopy geth %USERPROFILE%\Desktop\Blockchain\geth /E
copy contractIncomplete.txt %USERPROFILE%\Desktop\Blockchain
robocopy Ethash %USERPROFILE%\Desktop\Blockchain\Ethash /E
copy privateChain2.cmd %USERPROFILE%\Desktop\Blockchain
robocopy EthereumWallet %USERPROFILE%\Desktop\EthereumWallet /E
copy adminNode.txt %USERPROFILE%\Desktop\Blockchain
