from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
from account_type.schemas import AccountTypeCreate, AccountType
import psycopg2
import json, random
from psycopg2 import errors as psycopg_errors
import re


def create_account_type(item_form_data: AccountTypeCreate):
    conn = get_db_connection()
    cursor = conn.cursor()


    query = """
    INSERT INTO account_type (
        tenant_id,
        type_name,
        created_at
    ) VALUES (%s, %s, %s) RETURNING *;
    """
    try:
        type_name = re.sub(r'\w+', lambda m:m.group(0).capitalize(), item_form_data.type_name)
        values = (
            item_form_data.tenant_id,
            type_name,
            item_form_data.created_at
        )
        cursor.execute(query, values)
        new_item = cursor.fetchone()
    
        conn.commit()
        conn.close()

        if new_item:
            data ={
                "account_type_id" : new_item[0],
                "tenant_id" : new_item[1],
                "type_name" : new_item[2],
            }
            error_response = {"msg": "Account Type created sucessfully", "code": 201, "data": data}
            return json.dumps(error_response)
        else:
            error_response = {"msg": "Account Type already exists", "code": 400}
            return json.dumps(error_response)

    except psycopg_errors.UniqueViolation as e:
        # Catch psycopg2 UniqueViolation error
        error_response = {"msg": "Account Type already exists", "code": 409}
        return json.dumps(error_response)

    except psycopg2.Error as e:
        # Handle other psycopg2 errors       
        error_response = {"msg": f"Database error: {e}", "code": 500}
        return json.dumps(error_response)

    except Exception as e:
        # Handle any other unexpected errors
        error_response = {"msg": f"Unexpected error: {e}", "code": 500}
        return json.dumps(error_response)


def get_all_account_type(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()
    
    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
            SELECT * FROM account_type WHERE tenant_id = %s AND lower(type_name) LIKE %s 
            ORDER BY created_at DESC 
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, searchTerm, offset, limit))
        account_types = cursor.fetchall()
    else:
        query = """
            SELECT * FROM account_type WHERE tenant_id = %s 
            ORDER BY created_at DESC
            OFFSET %s LIMIT %s;
            """
        cursor.execute(query,(tenant_id, offset, limit))
        account_types = cursor.fetchall()
        
    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM account_type WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id,))
    total_count = cursor.fetchone()
    
    conn.close()
    
    if account_types:
        return {
            "data": [
                AccountType(
                    account_type_id=row[0],
                    tenant_id=row[1],
                    type_name=row[2],
                    created_at=row[3]
                )
                for row in account_types
            ],
            "total_count": total_count
        }
    else:
        None


def update_account_type(account_type_id: int,  item_form_data: AccountTypeCreate) -> Optional[AccountType]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE account_type SET 
        type_name = %s
    WHERE account_type_id = %s RETURNING *;
    """

    values = (
        item_form_data.type_name,
        account_type_id
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return AccountType(
            account_type_id=updated_itemm[0],
            tenant_id=updated_itemm[1],
            type_name=updated_itemm[2],
            created_at=updated_itemm[3]
        )
    else:
        raise HTTPException(status_code=404, detail="Account Type update failed")


def delete_account_type(account_type_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM account_type WHERE account_type_id = %s RETURNING account_type_id;"
    cursor.execute(query, (account_type_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False
    
def delete_all_account_type(tenant_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM account_type WHERE tenant_id = %s RETURNING account_type_id;"
    cursor.execute(query, (tenant_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False


def get_account_type_by_id(account_type_id: int) -> Optional[AccountType]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "SELECT * FROM account_type WHERE account_type_id = %s ;"

    cursor.execute(query, (account_type_id,))
    get_all_items = cursor.fetchone()

    conn.close()

    if get_all_items:
        return AccountType (
                account_type_id=get_all_items[0],
                tenant_id=get_all_items[1],
                type_name=get_all_items[2],
                created_at=get_all_items[3]
            )
    else:
        return None


