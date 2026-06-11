# Pierrot s'est fait pirater

## Sécuriser ses applications Shiny

### La présentation

La vidéo : _à venir_

Les slides : [https://arthurdata.github.io/rencontresR2026](https://arthurdata.github.io/rencontresR2026)

## Présentation pour les Rencontres R 2026

> Passage le **mardi 16 juin 2026 — 16:20–16:40** (20 min)

Programme complet : [rr2026.sciencesconf.org/program](https://rr2026.sciencesconf.org/program?lang=fr)

## Abstract

Pierrot est développeur R. Il maquette ses apps, il les teste, il les livre. Il est fier de son travail. Mais un jour, son application se fait pirater.

Dans la continuité des éditions précédentes des Rencontres R, nous retrouvons Pierrot confronté à un nouveau défi : la sécurité de ses applications Shiny. Un sujet souvent négligé dans l'écosystème R, pourtant bien réel.

Nous explorerons les principales vulnérabilités auxquelles s'exposent les applications Shiny : **injections XSS**, **Command Injection** et **SQL Injection**. Des failles qui peuvent sembler abstraites… jusqu'au jour où elles touchent votre propre application. Nous verrons comment les identifier, les reproduire et surtout comment s'en protéger avec des bonnes pratiques concrètes et accessibles.

Car la sécurité n'est pas réservée aux experts en cybersécurité. Elle fait partie du métier de développeur, au même titre que les tests ou la documentation.

## Démos & code

Toutes les apps Shiny démonstratives sont dans [`security/apps/`](security/apps/) :

| Reprex | Sujet |
|---|---|
| `reprex1`, `reprex2` | Échappement HTML par défaut vs `HTML()` (le teasing XSS) |
| `reprex3`, `reprex4` | Command Injection via `glue()` (safe vs vulnérable) |
| `reprex5` | `selectInput` contourné via console JS |
| `reprex6` | Insecure Deserialization (`.rds` malveillant) |
| `reprex7`, `reprex8`, `reprex9` | SQL Injection (textInput, selectInput, `sqlInterpolate` fix) |
| `reprex11` | Stored XSS sur un mur de commentaires |

Chacune se lance avec :

```r
shiny::runApp("security/apps/reprexN")
```

Le payload de désérialisation est généré par [`security/evil/make_evil.R`](security/evil/make_evil.R).

## Précédentes éditions

- 2023 — [La maquette](https://arthurdata.github.io/rencontresR2023)
- 2025 — [Les tests](https://arthurdata.github.io/rencontresR2025)

## Détails

Les animations Lottie utilisées dans cette présentation proviennent de [LottieFiles](https://lottiefiles.com/).

## Extensions

- Pour le format : [thinkridentity](https://github.com/ThinkR-open/thinkridentity) de [ThinkR-open](https://github.com/ThinkR-open/)
- Pour ajouter les animations Lottie : [quarto-lottie](https://github.com/ArthurData/quarto-lottie)
