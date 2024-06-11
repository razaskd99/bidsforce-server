from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
from persona.schemas import PersonaCreate, Persona
import psycopg2
import json, random
from psycopg2 import errors as psycopg_errors
import datetime

def create_persona(item_form_data: PersonaCreate):
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    INSERT INTO persona (
        tenant_id,
        persona_role,
        description,
        is_active,
        created_on
    ) VALUES (%s, %s, %s, %s, %s) RETURNING *;
    """

    try:
        values = (
            item_form_data.tenant_id,
            item_form_data.persona_role,
            item_form_data.description,
            item_form_data.is_active,
            item_form_data.created_on
        )
        cursor.execute(query, values)
        new_item = cursor.fetchone()   
        conn.commit()
        conn.close()
        
        if new_item: 
            data = {
                    "persona_id": new_item[0],
                    "tenant_id": new_item[1],
                    "persona_role": new_item[2],
                    "description":new_item[3],
                }          
            error_response = {"msg": "Persona created sucessfully", "code": 201, "data": data}
            return json.dumps(error_response)
        else:
            error_response = {"msg": "Persona already exists", "code": 400}
            return json.dumps(error_response)

    except psycopg_errors.UniqueViolation as e:
        # Catch psycopg2 UniqueViolation error
        error_response = {"msg": "Persona already exists", "code": 409}
        return json.dumps(error_response)

    except psycopg2.Error as e:
        # Handle other psycopg2 errors       
        error_response = {"msg": f"Database error: {e}", "code": 500}
        return json.dumps(error_response)

    except Exception as e:
        # Handle any other unexpected errors
        error_response = {"msg": f"Unexpected error: {e}", "code": 500}
        return json.dumps(error_response)
        
   
    
def get_all_persona(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM persona              
                WHERE tenant_id = %s AND lower(persona_role) LIKE %s
            ORDER BY created_on DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, searchTerm, offset, limit))
        query_all_items = cursor.fetchall()
    else:
        query = """
            SELECT * FROM persona              
                WHERE tenant_id = %s 
            ORDER BY created_on DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, offset, limit))
        query_all_items = cursor.fetchall()
        
    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM persona WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id, ))
    total_count = cursor.fetchone()
    conn.close()    
    
    if query_all_items:
        return {
            "data": [
                Persona(
                    persona_id=row[0],
                    tenant_id=row[1],
                    persona_role=row[2],
                    description=row[3],
                    is_active=row[4],
                    created_on=row[5]
                )
                for row in query_all_items
            ],
            "total_count": total_count
        }
    else:
        None


def update_persona(persona_id: int,  item_form_data: PersonaCreate) -> Optional[Persona]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE persona SET 
        persona_role = %s,
        description = %s,
        is_active = %s
    WHERE persona_id = %s RETURNING *;
    """

    values = (
        item_form_data.persona_role,
        item_form_data.description,
        item_form_data.is_active,
        persona_id
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return Persona(
            persona_id=updated_itemm[0],
            tenant_id=updated_itemm[1],
            persona_role=updated_itemm[2],
            description=updated_itemm[3],
            is_active=updated_itemm[4],
            created_on=updated_itemm[5]
        )
    else:
        raise HTTPException(status_code=404, detail="Bid Validity update failed")


def delete_persona(persona_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM persona WHERE persona_id = %s RETURNING persona_id;"
    cursor.execute(query, (persona_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False
    
def delete_all_persona(tenant_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM persona WHERE tenant_id = %s RETURNING persona_id;"
    cursor.execute(query, (tenant_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False


def get_persona_by_id(persona_id: int) -> Optional[Persona]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM persona WHERE persona_id = %s ;"

    cursor.execute(query, (persona_id,))
    get_one_item = cursor.fetchone()

    conn.close()

    if get_one_item:
        return Persona (
                persona_id=get_one_item[0],
                tenant_id=get_one_item[1],
                persona_role=get_one_item[2],
                description=get_one_item[3],
                is_active=get_one_item[4],
                created_on=get_one_item[5]
            )
    else:
        return None


def get_persona_by_name(title : str, tenant_id: int) -> Optional[Persona]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM persona WHERE lower(title) = %s AND tenant_id = %s RETURNING *;"

    cursor.execute(query, (title.lower(), tenant_id))
    get_item = cursor.fetchone()

    conn.close()

    if get_item:
        return Persona(
                persona_id=get_item[0],
                tenant_id=get_item[1],
                rfx_id=get_item[2],
                title=get_item[3],
                is_active=get_item[4]
            )
    else:
        return None
    

