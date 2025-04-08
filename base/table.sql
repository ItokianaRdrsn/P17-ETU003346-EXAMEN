CREATE TABLE webDym_credit(
    id int primary key auto_increment,
    libelle varchar(255) ,
    montant decimal(14,2) default 0
);

CREATE TABLE webDym_depense(
    id int primary key auto_increment,
    id_credit int references webDym_credit(id),
    montant decimal(14,2) default 0,
    date_depense date 
);

