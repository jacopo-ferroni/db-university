-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * 
FROM `students` 
WHERE `date_of_birth` LIKE '%1990%';

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * 
FROM `courses` 
WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * 
FROM `students` 
WHERE `date_of_birth` < DATE_SUB(current_date(), interval 30 YEAR);

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * 
FROM `courses` 
WHERE `period` = 'I semestre' 
AND `year` = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * 
FROM `exams` 
WHERE `date` = '2020/06/20' 
AND `hour` >= 14;

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT * 
FROM `degrees` 
WHERE `level`= 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(*) 
AS `name` 
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(*) 
as `phone` 
FROM `teachers` 
WHERE `phone` IS NULL;

-----------------------> part 2 <-----------------------

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*) AS 'Iscrizioni_annuali', YEAR(`enrolment_date`) AS 'anno'
FROM `students` 
GROUP BY YEAR(`enrolment_date`);

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(*) AS 'Professori_presenti', `office_address` AS 'Indirizzo-Ufficio' 
FROM `teachers` 
GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT AVG(`vote`) AS 'Media_Voti', `exam_id` 
FROM `exam_student` 
GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(*) AS 'Somma_Corsi', `degree_id` AS 'ID_corso_di_laurea' 
FROM `courses` 
GROUP BY `degree_id`;

-----------------------> part 3 <-----------------------

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT * 
FROM `students` 
INNER JOIN `degrees` ON `students`.`degree_id` = `degrees`.`id` 
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del dipartimento di Neuro Scienze
SELECT * 
FROM `degrees` 
INNER JOIN `departments` ON `degrees`.`department_id` = `departments`.`id` 
WHERE `departments`.`id` = 7;

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT * 
FROM `course_teacher` 
INNER JOIN `teachers` ON `teachers`.`id` = `teacher_id` 
WHERE `teacher_id` = 44 

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`surname`, `students`.`name`, `degrees`.`name`, `departements`.`name`
FROM `students`
INNER JOIN `degrees` on `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments` on `departements.id` = `degrees`.`department_id`
ORDER BY `students`.`name`;

