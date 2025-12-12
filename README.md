# HomeDMX

**HomeDMX** est une application de gestion de lumières pilotée en DMX via un Raspberry Pi

Le frontend est géré par l'API de QLC+

4 canaux :
 - Red
 - Green
 - Blue
 - Alpha (0 - 189) -- Blink (190 - 254) -- Max luminosité (255)

6 groupes : 1 par spot

## TODO

 - Rajouter la liste des animations    
   - Blink avec couleurs aléatoires
   - Fade avec couleurs aléatoires
   - Chenille
   - Avec des paramètres sur des sliders :
     - vitesse
     - realease
     - keep   
