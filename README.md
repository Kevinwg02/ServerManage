# DockerScript

Il faut ce souvenir pour docker qu'il isole le container. C'est le but! Il faut donc dans la commande ajouter le dossier que l'on veux lier. 
<br>
<img src="plexlogo.jpg" width="150px" />
<br>
Attention pour plex il y a 2 points: 

-Il faut ajouter la clef claim pour l'ajouter depuis votre compte. Vous trouverez cette clef une fois connecter à https://app.plex.tv/ <br>
-Il faut pensé au réseau. Sil vous le mettez dans un sous réseau dans docker ou en bridge il y aura un impact sur les performances. Vous devez privilégier "network=host".
