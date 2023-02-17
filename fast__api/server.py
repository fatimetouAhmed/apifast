from fastapi import FastAPI, File, UploadFile,HTTPException,Header
import uvicorn
#from prediction import read_image
from starlette.responses import JSONResponse
from prediction import predict_face
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from sqlalchemy import create_engine, Column, Integer, String ,Sequence,and_
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import datetime
from dbconfig import etudiermat ,examun ,Base ,session,engine


app=FastAPI()



@app.get('/')
def hello_world():
    return "hello world"
@app.post('/api/predict')

async def predict_image(file :UploadFile=File(...)):
    #read file upload par user
    #image = read_image(file)
    #try:

        image = await file.read()
        with open("image.jpg", "wb") as f:
            f.write(image)
        result = predict_face("image.jpg")
        #JSONResponse(content=result)
    #except Exception as e:
       # return {"error": str(e)}
        return result 





if __name__== "__main__":
   uvicorn.run(app,port=8000 ,host='192.168.190.113')