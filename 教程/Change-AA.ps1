function Change-Asciiart([string]${ROOT})
{
${Out-File}= $Root.Substring(0,$Root.Length-4)+".html"
$AA = Get-Content ${ROOT}
foreach($line in $AA )
{
[string]$out =  '<p style="font-family:ＭＳ Ｐゴシック;font-size:16px;line-height:18px;color:#333333;margin:2px;">'+$line+'<br/>' >> ${Out-File}
}
${AA-Foot} = @'
<script>(function(){var d=document,s=d.createElement('style'),h=d.getElementsByTagName('head');s.setAttribute('type', 'text\/css');s.innerHTML='@font-face {font-family: "Saitamaar";src: url("https://keage.tokyo/fonts/Saitamaar.woff2") format("woff2");}* {font-family: "Saitamaar" !important;}';h[0].appendChild(s);})();</script>
'@ 
Write-Output ${AA-Foot} >> ${Out-File}
}

${Root}= Get-Location
${AA-List} = Get-ChildItem ${Root} | Where-Object {$_.Extension -eq ".txt"} | Select-Object -Property Name

foreach(${AA} in ${AA-List}.name)
{
${AA_ROOT} = ${Root}.ToString()+'/'+${AA}
Change-Asciiart(${AA_ROOT})
Write-Output $AA_ROOT >> AA-Change.log
}
Write-Output ((Get-Date).ToString( )+ "   已转换成功以上TXT文件.") >> AA-Change.log
