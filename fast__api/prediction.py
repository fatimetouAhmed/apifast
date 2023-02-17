from PIL import Image
from io import BytesIO
import deepface
from deepface import DeepFace
from pydantic import BaseModel
import pandas as pd
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from sqlalchemy import create_engine, Column, Integer, String ,Sequence
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from dbconfig import get_etudiant
#from config.db import conn
#from models.students import etudiants
#Base = declarative_base()
# Create engine and connect to the database
#engine = create_engine("mysql+pymysql://root@localhost:3308/flutter_db")
#conn = engine.connect()
# Create a session factory
#Session = sessionmaker(bind=engine)

# Create a session
#session = Session()

#class Etudiant(Base):
 #      __tablename__ = 'etudiant'
  #     id = Column('id', Integer, Sequence('etudiant_id_seq'), primary_key=True)
  #     Nom = Column('Nom', String)
   #    Prenon = Column('Prenom', String)
    #   email = Column('email', String)
     #  photo = Column('photo', String)
      # filiere = Column('filiere', String)
       #niveau = Column('niveau', String)
       #semestere = Column('semestere', String)

#Base.metadata.create_all(engine)

#def get_etudiant(photo: str):
    # Query the users table
 #   etudiants = session.query(Etudiant.Nom,Etudiant.Prenon,Etudiant.filiere,Etudiant.email,Etudiant.niveau,).filter(Etudiant.photo==photo).all()
    #etudiants=conn.execute(Etudiant.select().where(Etudiant.photo==photo)).fetchall()
    # Convert the results to a list of dictionaries
    #etudiants_list = [etudiant.__dict__ for etudiant in etudiants]
  #  etudiants_list = [dict(zip(['Nom', 'prenom','filiere', 'email','niveau'], etudiant)) for etudiant in etudiants]

   # if not etudiants_list:
    #    return JSONResponse(content=jsonable_encoder({'error': 'Etudiant non trouvé'}))
    
    # Return the response as a JSON
    #return JSONResponse(content=jsonable_encoder(etudiants_list))

def predict_face(image_path):
    #result = DeepFace.verify(image_path, img2_path = "image.jpg")
        results = DeepFace.find(img_path =image_path, db_path = "C:/Users/pc/Desktop/backflutter/fastapi/image",enforce_detection=False)
   #    try:  #if  results
        photo = list(map(lambda x: x['identity'],results))
        
        if not photo:
          return {"etudiant n existe pas"}
        else:
          url=photo[0][0]
          print(url)
          donne=get_etudiant(url)
          return donne
      
      #  except Exception as e:
      #   return {"etudiant n existe pas"}
       #else:
     #    return 'etudiant n existe pas' 
 
    
    # Convertir la série en objet JSON
    #data_json = data.to_json(orient='values')
    #res=data_json.replace(" \ ", "")
     # result1= result.to_json()
    #if data_json is None:
     #   return {"error": "No face detected in the image"}
