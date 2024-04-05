import mysql.connector

class Connection:
    
    def isEntryPresent(self,username):
        try:
            conn = mysql.connector.connect(
                host='Prasad25.mysql.pythonanywhere-services.com',
                user='Prasad25',
                password='8956652382##Prasad25',
                database='Prasad25$bigbite'
            )
            

            if conn.is_connected():
                print("connected for entry chack")
                cursor = conn.cursor()
         
             
                
                select_query = "SELECT * FROM userinfo WHERE username = %s"
                cursor.execute(select_query, (username,))
                rows = cursor.fetchall()

                if rows:
                    print("Entry for '{}' is present in the database.".format(username))
                    return True
                else:
                    print("Entry for '{}' is not present in the database.".format(username)),404
                    return False
                
        except mysql.connector.Error as err:
            print("Error:", err)
        return False    
            
    def checkLoginInfo(self, name, password):
        try:
            conn = mysql.connector.connect(
                host='Prasad25.mysql.pythonanywhere-services.com',
                user='Prasad25',
                password='8956652382##Prasad25',
                database='Prasad25$bigbite'
            )

            
            if conn.is_connected():
                print("Connected successfully")
                cursor = conn.cursor()

                if(obj.isEntryPresent(name)):
                    select_query = "SELECT password FROM userinfo WHERE username = %s"
                    cursor.execute(select_query, (name,))
                
                # Fetch the stored password
                    row = cursor.fetchone()

                    if row:
                        stored_password = row[0]
                        if password == stored_password:
                            print("Authentication successful")
                            return True
                        else:
                            print("Authentication failed: Incorrect password")
                            return False
                    else:
                        print("Authentication failed: Username not found")
                        return False
                else:
                    return False
          
        except mysql.connector.Error as err:
            print("Error:", err)
            # Rollback transaction in case of error
            conn.rollback()
        finally:
            # Close cursor and connection
            cursor.close()
            conn.close()
            
    def insertInToDataBase(self, name, password,contact):
        try:
            conn = mysql.connector.connect(
                host='Prasad25.mysql.pythonanywhere-services.com',
                user='Prasad25',
                password='8956652382##Prasad25',
                database='Prasad25$bigbite'
            )

            
            if conn.is_connected():
                print("Connected successfully")
                cursor = conn.cursor()

                insert_query = """
                INSERT INTO userinfo (username, password,contact) 
                VALUES (%s, %s,%s)
                """
                data = (name, password,contact)

                cursor.execute(insert_query, data)
                conn.commit()
                print("Data inserted successfully")
                
        except mysql.connector.Error as err:
            print("Error:", err)
            # Rollback transaction in case of error
            conn.rollback()
                
            
    def addIpInDataBase(self,username,ipAddress):
        try:
            conn = mysql.connector.connect(
                host='Prasad25.mysql.pythonanywhere-services.com',
                user='Prasad25',
                password='8956652382##Prasad25',
                database='Prasad25$bigbite'
            )

            
            if conn.is_connected():
                print("Connected successfully for ip")
                cursor = conn.cursor()

                insert_query = """
                INSERT INTO ipinfo (username, ipaddress) 
                VALUES (%s, %s)
                """
                data = (username, ipAddress)

                cursor.execute(insert_query, data)
                conn.commit()
                print("IP Address inserted succefully")
                
        except mysql.connector.Error as err:
            print("Error:", err)
            # Rollback transaction in case of error
            conn.rollback()
            
    def isClassEntryPresentInData(self,className,subjectName):
        try:
            conn = mysql.connector.connect(
                host='Prasad25.mysql.pythonanywhere-services.com',
                user='Prasad25',
                password='8956652382##Prasad25',
                database='Prasad25$bigbite'
            )
            

            if conn.is_connected():
                print("connected for class name chacking entry chack")
                cursor = conn.cursor()
        
                select_query = "SELECT * FROM Classes WHERE class_name = %s AND subject_name = %s"
                cursor.execute(select_query, (className,subjectName,))
                rows = cursor.fetchall()

                if rows:
                    print("Entry for '{}' is present in the database.".format(className))
                    return True
                else:
                    print("Entry for '{}' is not present in the database.".format(className)),404
                    return False
                
        except mysql.connector.Error as err:
            print("Error:", err)
        return False   
    
    def addClassInDataBase(self,className,subjectName,strength,dateOfCreation):
        try:
            conn = mysql.connector.connect(
                host='Prasad25.mysql.pythonanywhere-services.com',
                user='Prasad25',
                password='8956652382##Prasad25',
                database='Prasad25$bigbite'
            )

            
            if conn.is_connected():
                print("Connected successfully")
                cursor = conn.cursor()

                insert_query = """
                INSERT INTO Classes (class_name, subject_name,date_of_creation) 
                VALUES (%s, %s,%s)
                """
                data = (className, subjectName,dateOfCreation)

                cursor.execute(insert_query, data)
                conn.commit()
                print("new class inserted  successfully")
                
            return True
                
        except mysql.connector.Error as err:
            print("Error:", err)
            # Rollback transaction in case of error
            conn.rollback()
            
            return False
        
    def get_teacher_id(teacher_name):
    # Connect to MySQL database
    # Replace 'host', 'user', 'password', and 'database' with your actual database connection details
        conn = mysql.connector.connect(
                host='Prasad25.mysql.pythonanywhere-services.com',
                user='Prasad25',
                password='8956652382##Prasad25',
                database='Prasad25$bigbite'
            )        
        cursor = conn.cursor()

        # Execute query to fetch teacher_id for the specific teacher name
        cursor.execute("SELECT teacher_id FROM Teachers WHERE name = %s", (teacher_name,))
        teacher_id = cursor.fetchone()

        # Close database connection
        cursor.close()
        conn.close()

        return teacher_id[0] if teacher_id else None
            
obj = Connection()

