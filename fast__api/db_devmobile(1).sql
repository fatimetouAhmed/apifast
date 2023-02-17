-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le : ven. 17 fév. 2023 à 12:59
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `db_devmobile`
--

-- --------------------------------------------------------

--
-- Structure de la table `departement`
--

CREATE TABLE `departement` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `departement`
--

INSERT INTO `departement` (`id`, `nom`) VALUES
(1, 'info');

-- --------------------------------------------------------

--
-- Structure de la table `etudiant`
--

CREATE TABLE `etudiant` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `date_N` date DEFAULT NULL,
  `lieu_n` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` int(11) DEFAULT NULL,
  `nationalité` varchar(255) DEFAULT NULL,
  `date_insecription` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `etudiant`
--

INSERT INTO `etudiant` (`id`, `nom`, `prenom`, `photo`, `genre`, `date_N`, `lieu_n`, `email`, `telephone`, `nationalité`, `date_insecription`) VALUES
(1, 'ahmed', 'med', 'C:/Users/hp/Desktop/fastapi/image/elone1.jpg', 'M', '0000-00-00', 'nktt', 'ahmed@gmail.com', 22859674, 'rim', '0000-00-00'),
(4, 'blblbla', 'blbla', 'C:/Users/hp/Desktop/fastapi/image/jorjina.jpg', 'f', '2000-02-01', 'nktt', 'bla@gmail.com', 258562, 'rim', '0000-00-00');

-- --------------------------------------------------------

--
-- Structure de la table `etudiermat`
--

CREATE TABLE `etudiermat` (
  `id` int(11) NOT NULL,
  `id_mat` int(11) NOT NULL,
  `id_etu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `etudiermat`
--

INSERT INTO `etudiermat` (`id`, `id_mat`, `id_etu`) VALUES
(1, 1, 1),
(2, 2, 4);

-- --------------------------------------------------------

--
-- Structure de la table `examun`
--

CREATE TABLE `examun` (
  `id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `heure_deb` datetime DEFAULT NULL,
  `heure_fin` datetime DEFAULT NULL,
  `id_mat` int(11) NOT NULL,
  `id_sal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `examun`
--

INSERT INTO `examun` (`id`, `type`, `heure_deb`, `heure_fin`, `id_mat`, `id_sal`) VALUES
(1, 'SN', '2023-02-16 23:00:00', '2023-02-17 12:30:00', 1, 1),
(2, 'SN', '2023-02-17 12:16:41', '2023-02-17 14:16:41', 2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `filiere`
--

CREATE TABLE `filiere` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `id_dep` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `filiere`
--

INSERT INTO `filiere` (`id`, `nom`, `description`, `id_dep`) VALUES
(1, 'IG', 'informatique de Gestion', NULL),
(2, 'DI', 'developpement_Info', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `matiere`
--

CREATE TABLE `matiere` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `credit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `matiere`
--

INSERT INTO `matiere` (`id`, `titre`, `description`, `credit`) VALUES
(1, 'bd', 'base de donne', 4),
(2, 'fc', 'finance Comptablite', 4);

-- --------------------------------------------------------

--
-- Structure de la table `salle`
--

CREATE TABLE `salle` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `salle`
--

INSERT INTO `salle` (`id`, `nom`) VALUES
(1, 'Salle1'),
(2, 'Salle2');

-- --------------------------------------------------------

--
-- Structure de la table `semestre`
--

CREATE TABLE `semestre` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `id_fil` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `semestre`
--

INSERT INTO `semestre` (`id`, `nom`, `id_fil`) VALUES
(1, 'S1', 1),
(2, 'S2', 1);

-- --------------------------------------------------------

--
-- Structure de la table `sem_etu`
--

CREATE TABLE `sem_etu` (
  `id` int(11) NOT NULL,
  `id_sem` int(11) NOT NULL,
  `id_etu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `sem_etu`
--

INSERT INTO `sem_etu` (`id`, `id_sem`, `id_etu`) VALUES
(1, 1, 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `departement`
--
ALTER TABLE `departement`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `etudiermat`
--
ALTER TABLE `etudiermat`
  ADD PRIMARY KEY (`id`,`id_etu`) USING BTREE,
  ADD KEY `fketu` (`id_etu`),
  ADD KEY `FKMAT` (`id_mat`);

--
-- Index pour la table `examun`
--
ALTER TABLE `examun`
  ADD PRIMARY KEY (`id`,`id_mat`,`id_sal`),
  ADD KEY `fk2` (`id_mat`),
  ADD KEY `fk3` (`id_sal`);

--
-- Index pour la table `filiere`
--
ALTER TABLE `filiere`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dep` (`id_dep`);

--
-- Index pour la table `matiere`
--
ALTER TABLE `matiere`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `salle`
--
ALTER TABLE `salle`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `semestre`
--
ALTER TABLE `semestre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_fil` (`id_fil`);

--
-- Index pour la table `sem_etu`
--
ALTER TABLE `sem_etu`
  ADD PRIMARY KEY (`id`,`id_etu`,`id_sem`),
  ADD KEY `fk_sem` (`id_sem`),
  ADD KEY `fk_etu` (`id_etu`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `departement`
--
ALTER TABLE `departement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `etudiant`
--
ALTER TABLE `etudiant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `examun`
--
ALTER TABLE `examun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `filiere`
--
ALTER TABLE `filiere`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `matiere`
--
ALTER TABLE `matiere`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `salle`
--
ALTER TABLE `salle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `sem_etu`
--
ALTER TABLE `sem_etu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `etudiermat`
--
ALTER TABLE `etudiermat`
  ADD CONSTRAINT `FKMAT` FOREIGN KEY (`id_mat`) REFERENCES `matiere` (`id`),
  ADD CONSTRAINT `fketu` FOREIGN KEY (`id_etu`) REFERENCES `etudiant` (`id`);

--
-- Contraintes pour la table `examun`
--
ALTER TABLE `examun`
  ADD CONSTRAINT `fk2` FOREIGN KEY (`id_mat`) REFERENCES `matiere` (`id`),
  ADD CONSTRAINT `fk3` FOREIGN KEY (`id_sal`) REFERENCES `salle` (`id`);

--
-- Contraintes pour la table `filiere`
--
ALTER TABLE `filiere`
  ADD CONSTRAINT `filiere_ibfk_1` FOREIGN KEY (`id_dep`) REFERENCES `departement` (`id`);

--
-- Contraintes pour la table `semestre`
--
ALTER TABLE `semestre`
  ADD CONSTRAINT `semestre_ibfk_1` FOREIGN KEY (`id_fil`) REFERENCES `filiere` (`id`);

--
-- Contraintes pour la table `sem_etu`
--
ALTER TABLE `sem_etu`
  ADD CONSTRAINT `fk_etu` FOREIGN KEY (`id_etu`) REFERENCES `etudiant` (`id`),
  ADD CONSTRAINT `fk_sem` FOREIGN KEY (`id_sem`) REFERENCES `semestre` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
