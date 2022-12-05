create table School(
	id INT primary key identity(1,1),
	name Varchar(100) not null,
	adress varchar(100) not null
)

create table Instructor(
	id INT primary key identity(1,1),
	person_number Varchar(12) UNIQUE,
	name Varchar(100) NOT NULL,
	age Varchar(10),
	phone Varchar(15),
	adress Varchar(100),
	school_id INT Foreign key references school(id) NOT NULL
)

create table Student(
	id INT primary key identity(1,1),
	person_number Varchar(12) UNIQUE,
	name Varchar(100) NOT NULL,
	age Varchar(10),
	phone Varchar(15),
	adress Varchar(100),

)

create table Contact_details(
	student_id INT NOT NULL,
	instructor_id INT,
	person_number Varchar(12) UNIQUE,
	name Varchar(100) NOT NULL,
	phone Varchar(15),
	mail Varchar(100),
	adress Varchar(100),
	CONSTRAINT student_instructor_PK Primary key(student_id, instructor_id),
	CONSTRAINT student_FK Foreign key(student_id) references student(id) ON DELETE CASCADE,
	CONSTRAINT instructor_FK Foreign key(instructor_id) references instructor(id) ON DELETE CASCADE,
)
	
create table Lesson(
	id INT Primary key identity(1,1),
	instrument Varchar(100) NOT NULL,
	minimum_students INT NOT NULL,
	maximum_students INT,
	instructor_id INT Foreign key references Instructor(id) NOT NULL,

)

create table Student_lesson(
	student_id INT,
	lesson_id INT,
	CONSTRAINT student_lesson_FK Foreign key(student_id) references student(id) ON DELETE CASCADE,
	CONSTRAINT lesson_student_FK Foreign key(lesson_id) references lesson(id) ON DELETE CASCADE,
)

create table Ensemble(
	lesson_id INT NOT NULL,
	ensemble_price Decimal(10,5),
	genre Varchar(100) NOT NULL,
	CONSTRAINT lesson_enseble_PK Primary key(lesson_id),
	CONSTRAINT lesson_ensemble_FK Foreign key(lesson_id) references Lesson(id) ON DELETE CASCADE,
)

create table group_lesson(
	lesson_id INT NOT NULL,
	group_price Decimal(10,5),
	CONSTRAINT lesson_group_PK Primary key(lesson_id),
	CONSTRAINT lesson_group_FK Foreign key(lesson_id) references Lesson(id) ON DELETE CASCADE,
)

create table Individual(
	lesson_id INT NOT NULL,
	individual_price Decimal(10,5),
	CONSTRAINT lesson_individual_PK Primary key(lesson_id),
	CONSTRAINT lesson_individual_FK Foreign key(lesson_id) references Lesson(id) ON DELETE CASCADE,
)

create table Schedule_and_appointments(
	lesson_id INT NOT NULL,
	place Varchar(100) NOT NULL,
	lesson_period Date NOT NULL,
	CONSTRAINT lesson_schedule_PK Primary key(lesson_id),
	CONSTRAINT lesson_schedule_FK FOreign key(lesson_id) references Lesson(id) ON DELETE CASCADE,
)

create table pricing_scheme(
	lesson_id INT NOT NULL,
	beginner_price Decimal(10,5),
	intermediate_price Decimal(10,5),
	advanced_price Decimal(10,5),
	sibling_discount Decimal(10,5),
	CONSTRAINT lesson_scheme_PK Primary key(lesson_id),
	CONSTRAINT lesson_scheme_FK FOreign key(lesson_id) references Lesson(id),
)

create table renting_instrument(
	student_id INT NOT NULL,
	renting_price Decimal(10,5),
	renting_period Date,
	instrument_type Varchar(100),
	instrument_brand Varchar(100),
	CONSTRAINT student_renting_PK Primary key(student_id),
	CONSTRAINT student_renting_FK Foreign key (student_id) references Student(id) ON DELETE CASCADE,
)	

create table Siblings(
	id INT primary key identity(1,1),
	student_id INT NOT NULL,
	person_number Varchar(12) UNIQUE,
	name Varchar(100) NOT NULL,
	age Varchar(10),
	phone Varchar(15),
	adress Varchar(100),
	CONSTRAINT sibling_FK Foreign key (student_id) references Student(id) ON DELETE CASCADE,
)	