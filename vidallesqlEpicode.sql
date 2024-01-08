-- 1a) Creazione della tabella vendite
CREATE TABLE vendite (
    ID_transazione INT PRIMARY KEY,
    categoria_prodotto VARCHAR(50),
    costo_vendita DECIMAL(10, 2),
    sconto DECIMAL(5, 2)
);

-- 1b) Creazione della tabella dettagli_vendite
CREATE TABLE dettagli_vendite (
    ID_vendita INT,
    ID_transazione INT,
    data_transazione DATE,
    quantita INT,
    PRIMARY KEY (ID_vendita, ID_transazione),
    FOREIGN KEY (ID_transazione) REFERENCES vendite(ID_transazione)
);

-- 10a)Creazione della tabella clienti
CREATE TABLE clienti (
    IDCliente INT PRIMARY KEY,
    ID_vendita INT
);
-- 2a) Inserimento di dati di esempio nella tabella vendite
INSERT INTO vendite VALUES
(1, 'Elettronica', 500.00, 0.10),
(2, 'Abbigliamento', 200.00, 0.20),
(3, 'Casa', 300.00, 0.15),
(4, 'Elettronica', 700.00, 0.25),
(5, 'Abbigliamento', 150.00, 0.30),
(6, 'Casa', 400.00, 0.12),
(7, 'Elettronica', 600.00, 0.18),
(8, 'Abbigliamento', 250.00, 0.82),
(9, 'Casa', 350.00, 0.10),
(10, 'Elettronica', 800.00, 0.30),
(11, 'Abbigliamento', 180.00, 0.15),
(12, 'Elettronica', 750.00, 0.60),
(13, 'Casa', 420.00, 0.25),
(14, 'Abbigliamento', 280.00, 0.12),
(15, 'Casa', 320.00, 0.08),
(16, 'Elettronica', 900.00, 0.75),
(17, 'Abbigliamento', 200.00, 0.10),
(18, 'Casa', 380.00, 0.85),
(19, 'Elettronica', 720.00, 0.25),
(20, 'Abbigliamento', 170.00, 0.20),
(21, 'Casa', 480.00, 0.95),
(22, 'Elettronica', 720.00, 0.75),
(23, 'Abbigliamento', 270.00, 0.20),
(24, 'Casa', 380.00, 0.85),
(25, 'Elettronica', 720.00, 0.25),
(26, 'Abbigliamento', 170.00, 0.20),
(27, 'Casa', 380.00, 0.85),
(28, 'Elettronica', 720.00, 0.25),
(29, 'Abbigliamento', 170.00, 0.20),
(30, 'Casa', 350.00, 0.65),
(31, 'Elettronica', 520.00, 0.25),
(32, 'Abbigliamento', 170.00, 0.20);


-- 2b) Inserimento di dati di esempio nella tabella dettagli_vendite
INSERT INTO dettagli_vendite VALUES
(101, 1, '2024-01-01', 2),
(102, 2, '2024-01-02', 1),
(103, 3, '2024-01-03', 3),
(104, 4, '2024-01-01', 1),
(105, 5, '2024-01-02', 2),
(106, 6, '2024-01-03', 2),
(107, 7, '2024-01-04', 1),
(108, 8, '2024-01-05', 3),
(109, 9, '2024-01-06', 1),
(110, 10, '2024-01-07', 2),
(111, 11, '2024-01-08', 1),
(112, 12, '2024-01-09', 2),
(113, 13, '2024-12-10', 3),
(114, 14, '2024-01-11', 2),
(115, 15, '2024-01-12', 1),
(116, 16, '2024-03-13', 2),
(117, 17, '2024-10-14', 1),
(118, 18, '2024-01-15', 3),
(119, 19, '2024-11-16', 1),
(120, 20, '2024-01-17', 2),
(121, 21, '2024-01-06', 1),
(122, 22, '2024-01-07', 2),
(123, 23, '2024-01-08', 1),
(124, 24, '2024-01-09', 2),
(125, 25, '2024-12-10', 3),
(126, 26, '2024-01-11', 2),
(127, 27, '2024-01-12', 1),
(128, 28, '2024-03-13', 2),
(129, 29, '2024-10-14', 1),
(130, 30, '2024-01-15', 3),
(131, 31, '2024-11-16', 1),
(132, 32, '2024-01-17', 2);

-- 10b) Inserimento di dati di esempio nella tabella clienti
INSERT INTO clienti VALUES
(101, 6),
(102, 2),
(103, 3),
(104, 1),
(105, 2),
(106, 3),
(107, 4),
(108, 5),
(109, 6),
(200, 7);

--3) QUERY SEMPLICI 
--3a) le vendite avvenute in una specifica data(esempio: '2024-01-03')
SELECT *
FROM vendite v
JOIN dettagli_vendite dv ON v.ID_transazione = dv.ID_transazione
WHERE dv.data_transazione = '2024-01-03';

--3b) Elenco delle vendite con sconti maggiori del 50%
SELECT *
FROM vendite
WHERE sconto > 0.50;

--4) Aggregazione dei Dati
--4a) Calcola il totale delle vendite (costo) per categoria
SELECT categoria_prodotto, SUM(costo_vendita) AS totale_vendite
FROM vendite
GROUP BY categoria_prodotto;

--4b) Trova il numero totale di prodotti venduti per ogni categoria

SELECT categoria_prodotto, SUM(quantita) AS totale_prodotti_venduti
FROM dettagli_vendite dv
JOIN vendite v ON dv.ID_transazione = v.ID_transazione
GROUP BY categoria_prodotto;

--5) Funzioni di Data
--5a) Seleziona le vendite dell'ultimo trimestre
SELECT *
FROM vendite v
JOIN dettagli_vendite dv ON v.ID_transazione = dv.ID_transazione
WHERE dv.data_transazione >= '2024-10-01' AND dv.data_transazione <= '2024-12-31';

--5b)  Raggruppa le vendite per mese e calcola il totale delle vendite per ogni mese
SELECT 
   strftime('%m', dv.data_transazione) AS mese,
   SUM(v.costo_vendita) AS totale_vendite
FROM vendite v
JOIN dettagli_vendite dv ON v.ID_transazione = dv.ID_transazione
GROUP BY mese
ORDER BY mese;

--7) Analisi degli Sconti
--7a) Trova la categoria con lo sconto medio più alto
SELECT categoria_prodotto, AVG(sconto) AS sconto_medio
FROM vendite
GROUP BY categoria_prodotto
ORDER BY sconto_medio DESC
LIMIT 1;

--8) Variazioni delle Vendite
--8a) Confronta le vendite mese per mese e calcola l'incremento o il decremento delle vendite. 

SELECT 
   strftime('%m', dv.data_transazione) AS mese,
   SUM(v.costo_vendita) AS totale_vendite
FROM vendite v
JOIN dettagli_vendite dv ON v.ID_transazione = dv.ID_transazione
GROUP BY mese
ORDER BY mese;

--9)  Analisi Stagionale
--9a) Confronta le vendite totali in diverse stagioni.

SELECT 
    CASE 
        WHEN strftime('%m', dv.data_transazione) IN ('12', '01', '02') THEN 'Inverno'
        WHEN strftime('%m', dv.data_transazione) IN ('03', '04', '05') THEN 'Primavera'
        WHEN strftime('%m', dv.data_transazione) IN ('06', '07', '08') THEN 'Estate'
        WHEN strftime('%m', dv.data_transazione) IN ('09', '10', '11') THEN 'Autunno'
    END AS stagione,
    SUM(v.costo_vendita) AS vendite_totali
FROM vendite v
JOIN dettagli_vendite dv ON v.ID_transazione = dv.ID_transazione
GROUP BY stagione
ORDER BY stagione;

--10c) Clienti Fedeli

SELECT 
    c.IDCliente,
    COUNT(dv.ID_transazione) AS numero_acquisti
FROM clienti c
JOIN dettagli_vendite dv ON c.ID_vendita = dv.ID_transazione
GROUP BY c.IDCliente
ORDER BY numero_acquisti DESC
LIMIT 5;


