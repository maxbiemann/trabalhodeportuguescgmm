# Execute este script somente após instalar Git no seu computador.
# Se ainda não tiver um repositório Git, ele inicializará um aqui.

$repoPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoPath

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git não está instalado neste ambiente. Instale Git e rode o script novamente."
    exit 1
}

if (-not (Test-Path .git)) {
    git init
    git branch -M main
}

git add .

git commit -m "Atualiza timeline e perfil dos integrantes"

$remote = git remote
if (-not $remote) {
    Write-Host "Nenhum remote configurado. Adicione o GitHub remote com o comando abaixo e rode o script novamente:"
    Write-Host "git remote add origin <URL-do-seu-repositório>"
    exit 0
}

git push -u origin main
