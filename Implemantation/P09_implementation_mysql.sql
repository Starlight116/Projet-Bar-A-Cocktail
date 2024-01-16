-- Script de suppression si besoin
DROP TABLE IF EXISTS P09_Necessite;
DROP TABLE IF EXISTS P09_Compose;
DROP TABLE IF EXISTS P09_Ingredient;
DROP TABLE IF EXISTS P09_Ustensile;
DROP TABLE IF EXISTS P09_Cocktail;

-- Table Cocktail
CREATE TABLE P09_Cocktail(
    cocktail_nom VARCHAR(50) PRIMARY KEY,
    cocktail_prix FLOAT CHECK(cocktail_prix > 0),
    cocktail_verre VARCHAR(50) NOT NULL,
    cocktail_categorie VARCHAR(50) CHECK(cocktail_categorie IN ('long-drink', 'short-drink', 'after-dinner')),
    cocktail_photo VARCHAR(50),
    cocktail_preparation TEXT,
    cocktail_alcoolise BOOLEAN NOT NULL
);

-- Table Ustensile
CREATE TABLE P09_Ustensile(
    ustensile_nom VARCHAR(50) PRIMARY KEY,
    ustensile_categorie VARCHAR(50)
        CHECK(ustensile_categorie IN ('couper', 'ecraser', 'melanger', 'boire', 'filtrer', 'doser', 'chauffer',
                                      'decorer'))
);

-- Table Ingredient
CREATE TABLE P09_Ingredient(
    ingredient_nom VARCHAR(50) PRIMARY KEY,
    ingredient_stock FLOAT CHECK(ingredient_stock > 0),
    ingredient_type VARCHAR(50)
        CHECK(ingredient_type IN ('soda', 'jus', 'diluant', 'fruit', 'alcool', 'aliment', 'epice', 'sirop',
                                  'edulcorant', 'condiment'))
);

-- Table Compose
CREATE TABLE P09_Compose(
    cocktail_nom VARCHAR(50),
    ingredient_nom VARCHAR(50),
    quantite FLOAT CHECK(quantite > 0),
    FOREIGN KEY (cocktail_nom) REFERENCES P09_Cocktail(cocktail_nom),
    FOREIGN KEY (ingredient_nom) REFERENCES P09_Ingredient(ingredient_nom),
    PRIMARY KEY (cocktail_nom, ingredient_nom)
);

-- Table Necessite
CREATE TABLE P09_Necessite(
    cocktail_nom VARCHAR(50),
    ustensile_nom VARCHAR(50),
    FOREIGN KEY (cocktail_nom) REFERENCES P09_Cocktail(cocktail_nom),
    FOREIGN KEY (ustensile_nom) REFERENCES P09_Ustensile(ustensile_nom),
    PRIMARY KEY (cocktail_nom, ustensile_nom)
);