CREATE OR REPLACE FUNCTION trigCocktails() RETURNS TRIGGER AS $$
DECLARE
    nbCocktails integer;
BEGIN
    SELECT count(*) INTO nbCocktails FROM P09_Cocktail; 

    IF TG_OP = 'UPDATE'
        THEN RAISE NOTICE 'On a modifié des lignes dans P09_Cocktail';
    ELSEIF TG_OP = 'INSERT'
        THEN RAISE NOTICE 'Il y a maintenant % cocktails sur le menu', nbCocktails;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigCocktailUp
    AFTER UPDATE OR INSERT ON P09_Cocktail FOR EACH STATEMENT
    EXECUTE FUNCTION trigCocktails();


UPDATE P09_Cocktail SET cocktail_verre = 'old fashioned' WHERE cocktail_verre = 'whisky';
-- un trigger après insertion d'une ligne dans cette table serait nécéssaire pour rappeler à l'utilisateur 
--qu'il faut qu'il ajoute des ingrédients pour cette recette
-- mais celui-ci n'étant pas demandé dans les consignes on insère sans se prendre la tête ici
INSERT INTO P09_Cocktail VALUES('daiquiri',3,'martini','short-drink','d.png','Frapper tout les ingrédients avec des glaçons et passer dans le verre.', TRUE);
