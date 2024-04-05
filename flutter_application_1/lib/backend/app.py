from flask import Flask, request, jsonify
from database import Connection
import json


connection = Connection()
app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    ipadress = data.get('ipAdress')
    print(ipadress)
   # if username == 'ppp' and password == '1512':
   
    if(connection.checkLoginInfo(username,password)):
        connection.addIpInDataBase(username,ipadress)
        return jsonify({'message': 'Login successful'})
    
    else:
        return jsonify({'message': 'Invalid credentials'}), 401

@app.route('/singUp',methods = ['post'])  
def singUp():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    contact = data.get('contact')
    
    if(connection.isEntryPresent(username)):
        return jsonify({'message': 'already present'}), 401
    
    else:
        connection.insertInToDataBase(username,password,contact)
        return jsonify({'message': 'added succefuly'})
    
    

    
@app.route('/createClassroom', methods=['POST'])
def createClassroom():
    data = request.get_json()
    className = data.get('className')
    subjectName = data.get('subjectName')
    strength = data.get('strength')
    dateOfCreation = data.get('dateOfCreation')
  
   # if username == 'ppp' and password == '1512':
   
    if(not connection.isClassEntryPresentInData(className,subjectName)):
        if(connection.addClassInDataBase(className,subjectName,strength,dateOfCreation)):
            return jsonify({'message': 'class added succefuly'})
        else:
            return jsonify({'message': 'Invalid credentials'}), 401
    
    else:
        return jsonify({'message': 'Invalid credentials'}), 401
    

             
'''if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)'''


