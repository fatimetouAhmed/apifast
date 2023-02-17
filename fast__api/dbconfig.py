from PIL import Image
from io import BytesIO
import deepface
from deepface import DeepFace
from pydantic import BaseModel
import pandas as pd
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from sqlalchemy import create_engine, Column, Integer, String ,Sequence ,ForeignKey ,Date ,DateTime, and_
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker
from sqlalchemy.orm import relationship, mapper, sessionmaker

from sqlalchemy import create_engine, Column, Integer, ForeignKey
from sqlalchemy.orm import relationship, mapper, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import datetime

Base = declarative_base()
# Create engine and connect to the database
engine = create_engine("mysql+pymysql://root@localhost:3306/bd_face")
conn = engine.connect()
# Create a session factory
Session = sessionmaker(bind=engine)
# Create a session
session = Session()


#etudiant
class etudiant(Base):
       __tablename__ = 'etudiant'
       id = Column('id', Integer, Sequence('etudiant_id_seq'), primary_key=True)
       Nom = Column('nom', String)
       Prenon = Column('prenom', String)
       email = Column('email', String)
       photo = Column('photo', String)
       genre  = Column('genre', String)
       date_N = Column('date_N', Date)
       lieu_n = Column('lieu_n', String)
       telephone = Column('telephone', Integer)
       nationalité= Column('nationalité', String)
       date_insecription  = Column(' date_insecription ', Date)
       sem_etu = relationship("sem_etu")
       etudiermat=relationship("etudiermat")
       #sem_etu= relationship("sem_etu", back_populates="etudiant")
       #sem_etu = relationship("sem_etu", backref="etudiant_backref")
     
       Base.metadata.create_all(engine)


#departement
class departement(Base):
     __tablename__ = 'departement'
     id = Column('id', Integer, Sequence('departement_id_seq'), primary_key=True)
     nom = Column('nom', String)   
     filiere = relationship("filiere", back_populates="departement")
Base.metadata.create_all(engine)

#filiere
class filiere(Base):
     __tablename__ = 'filiere'
     id = Column('id', Integer, Sequence('filiere_id_seq'), primary_key=True)
     nom = Column('nom', String)  
     description = Column('description', String) 
     id_dep = Column('id_dep',Integer, ForeignKey('departement.id'))
     departement = relationship("departement", back_populates="filiere")
     semestre= relationship("semestre", back_populates="filiere")

Base.metadata.create_all(engine)

#matiere
class matiere(Base):
     __tablename__ = 'matiere'
     id = Column('id', Integer, Sequence('matiere_id_seq'), primary_key=True)
     titre  = Column('titre', String)  
     description = Column('description', String) 
     credit= Column('credit',Integer)
     examun = relationship("examun", back_populates="matiere")
     etudiermat=relationship("etudiermat")


Base.metadata.create_all(engine)

#examun
class examun(Base):
     __tablename__ = 'examun'
     id = Column('id', Integer, Sequence('examun_id_seq'), primary_key=True)
     type = Column('type', String) 
     heure_deb= Column('heure_deb',DateTime)
     heure_fin= Column('heure_fin',DateTime)
     id_mat= Column('id_mat',Integer, ForeignKey('matiere.id'))
     id_sal= Column('id_sal',Integer, ForeignKey('salle.id'))
     matiere = relationship("matiere", back_populates="examun")
     salle = relationship("salle", back_populates="examun")
Base.metadata.create_all(engine)
#salle
class salle(Base):
     __tablename__ = 'salle'
     id = Column('id', Integer, Sequence('salle-id'), primary_key=True)
     nom = Column('nom', String) 
     examun = relationship("examun", back_populates="salle")
Base.metadata.create_all(engine)

#semestre
class semestre(Base):
     __tablename__ = 'semestre'
     id = Column('id', Integer, Sequence('semestre-id'), primary_key=True)
     nom = Column('nom', String)
     id_fil= Column('id_fil',Integer, ForeignKey('filiere.id'))
     filiere= relationship("filiere", back_populates="semestre")
     sem_etu= relationship("sem_etu", back_populates="semestre")

Base.metadata.create_all(engine)
#sem_etu
class sem_etu(Base):
     __tablename__ = 'sem_etu'
     id = Column('id', Integer, Sequence('sem_etu-id'), primary_key=True)
     id_sem= Column('id_sem',Integer, ForeignKey('semestre.id'))
     id_etu= Column('id_etu',Integer, ForeignKey('etudiant.id'))
     semestre= relationship("semestre", back_populates="sem_etu")
     etudiant= relationship("etudiant", back_populates="sem_etu")

Base.metadata.create_all(engine)
#etudier_matiere
class etudiermat(Base):
     __tablename__ = 'etudiermat'
     id = Column('id', Integer, Sequence('etudiermat-id'), primary_key=True)
     id_mat= Column('id_mat',Integer, ForeignKey('matiere.id'))
     id_etu= Column('id_etu',Integer, ForeignKey('etudiant.id'))
     matiere= relationship("matiere", back_populates="etudiermat")
     etudiant= relationship("etudiant", back_populates="etudiermat")

Base.metadata.create_all(engine)

def get_exams():
    id_etu = 1
    now = datetime.datetime.now()

    Base.metadata.create_all(bind=engine)

    subquery = session.query(etudiermat.id_mat).filter(examun.id_etu == id_etu)
    exams = session.query(examun).filter(and_(now >= examun.heure_deb, now <= examun.heure_fin, examun.id_mat.in_(subquery))).all()

    return exams



def get_etudiant(photo: str):
    print(photo)
    # recuperer l'identifiant de l'etudiant apres la verification de l'image 
    etudiants = session.query(etudiant.id ,etudiant.Nom).filter(etudiant.photo==photo).all()
    #etudiants_list = [dict(zip([ 'id','Nom'], etudiant)) for etudiant in etudiants]
    id_etu=etudiants[0][0]
    now = datetime.datetime.now()
    print(now)
    #Base.metadata.create_all(bind=engine)
#verifier est ce que l'etudiant a un examun a ce moment
    subquery = session.query(etudiermat.id_mat).filter(etudiermat.id_etu == id_etu)
    exams = session.query(examun.id).filter(and_(now >= examun.heure_deb, now <= examun.heure_fin, examun.id_mat.in_(subquery))).all()
    #id_exam=exams[0][0]
    #examuns = [examun.__dict__ for examun in exams]
    if not exams :
        return  "votre examun n'est pas a ce moment"
    else :
          
     return    "rentrez"
    #if not etudiants_list:
       # return JSONResponse(content=jsonable_encoder({'error': 'Etudiant non trouvé'}))
    
    # Return the response as a JSON
    return JSONResponse(content=jsonable_encoder(etudiants_list))
