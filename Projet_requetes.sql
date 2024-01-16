
-- 4) Donner les requêtes mettant en œuvre les sous-requêtes suivantes
    --a) une sous-requête dans la clause WHERE via l'opérateur =
        --on cherche le cocktail qui utilise un fouet
            SELECT * FROM P09_Cocktail WHERE cocktail_nom = (SELECT cocktail_nom FROM P09_Necessite WHERE ustensile_nom="fouet");
    --b) une sous-requête dans la clause WHERE via l'opérateur IN (et nécessitant cet opérateur)
        --on cherche tout les cocktail dont un des ingrédient est le sucre
            SELECT cocktail_nom from P09_Cocktail WHERE cocktail_nom in (SELECT cocktail_nom FROM P09_Compose WHERE ingredient_nom = 'sucre');
            /* résultat attendu :
                +--------------+
                | cocktail_nom |
                +--------------+
                | eggnog       |
                | mint julep   |
                | vin chaud    |
                +--------------+
            */
    --c) une sous requête dans la clause FROM 
        --On cherche tout les ustensiles qui servent à décorer la boisson
            SELECT ustensile_nom FROM (SELECT ustensile_nom FROM P09_Ustensile WHERE ustensile_categorie = "decorer") as Decor;
            /* résultat attendu :
                +---------------+
                | ustensile_nom |
                +---------------+
                | eplucheur     |
                | pince a glace |
                | rape          |
                +---------------+
                */
    --d) une sous-requête imbriquée dans une autre sous-requête
        --On cherche la définition complète des recettes de cocktail qui utilisent un shaker
            SELECT * FROM P09_Cocktail WHERE cocktail_nom IN (SELECT cocktail_nom FROM (SELECT cocktail_nom FROM P09_Necessite WHERE ustensile_nom = "shaker") as UtiliseShaker );

    --e) une sous-requête synchronisée
        --on cherche les cocktails dont un des ingrédients est de la catégorie alcool
            SELECT * FROM P09_Compose A WHERE EXISTS (SELECT * from P09_Ingredient B WHERE A.ingredient_nom=B.ingredient_nom AND ingredient_type="alcool");
    --f) une sous-requêtes utilisant un opérateur de comparaison combiné ANY
        --on cherche les ingredients qui sont un alcool et dont la quantité en stock est plus grande que n'importe quelle quantité utilisé dans les recettes
            SELECT * FROM P09_Ingredient WHERE ingredient_type = "alcool" AND ingredient_stock > ANY(SELECT quantite FROM P09_Compose);
    --g) une sous-requête utilisant un opérateur de comparaison combiné ALL
        --on cherche les ingredients qui sont un alcool et dont la quantité en stock est plus grande que toutes les quantité utilisé dans les recettes
            SELECT * FROM P09_Ingredient WHERE ingredient_type = "alcool" AND ingredient_stock > ALL(SELECT quantite FROM P09_Compose);
--5) Donner un exemple de requête pouvant être réalisé avec une jointure ou avec une sous-requête. 
--Les deux requêtes équivalentes devront être fournies.
--Quelle requête est la plus efficace (justification attendue).
    --on affiche les ingredients de type fruit, dans quelles recettes ils sont utilisés et en quelle quantitée
    --cette requete peut être très utile pour chercher des allèrgènes dans une recette
        SELECT ingredient_nom, cocktail_nom, quantite FROM P09_Ingredient NATURAL JOIN P09_Compose WHERE ingredient_type="fruit";
        SELECT I.ingredient_nom,C.cocktail_nom,C.quantite FROM P09_Ingredient I, (SELECT * FROM P09_Compose) AS C WHERE I.ingredient_nom=C.ingredient_nom AND I.ingredient_type="fruit";
    /* la jointure est plus lisible, courte et rapide que la sous requête donc pour ce cas la jointure sera probablement la plus efficace a utiliser


