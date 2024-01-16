CREATE OR REPLACE FUNCTION trigCocktails() RETURNS TRIGGER AS $$

BEGIN
DECLARE
    nbCocktails integer;

    nbCocktails :- SELECT count(*) FROM P09_Cocktail; 
    IF TG_OP = 'UPDATE'
        THEN RAISE NOTICE 'On a modifié des lignes dans P09_Cocktail';
    ELSEIF TG_OP = 'INSERT'
        THEN RAISE NOTICE 'Il y a maintenant % cocktails sur le menu', nbCocktails;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plmysql;

CREATE OR REPLACE TRIGGER trigCocktailUp
    AFTER UPDATE OR INSERT ON P09_Cocktail FOR EACH STATEMENT
    EXECUTE FUNCTION trigCocktails();

UPDATE P09_Cocktail SET cocktail_verre = 'old fashioned' WHERE cocktail_verre = 'whisky';
