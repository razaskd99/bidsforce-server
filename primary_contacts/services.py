from typing import List, Optional
from fastapi import HTTPException
from db.connection import get_db_connection
import re
from primary_contacts.schemas import PrimaryContactsCreate, PrimaryContacts, PrimaryContactsSingleRecord


def create_primary_contacts(item_form_data: PrimaryContactsSingleRecord) -> PrimaryContactsSingleRecord:
    conn = get_db_connection()
    cursor = conn.cursor()


    query = """
    INSERT INTO primary_contacts (
        tenant_id, 
        company_id,
        designation_id,
        team_id,
        first_name, 
        last_name, 
        manager, 
        function_group, 
        contact_number, 
        time_zone, 
        email, 
        working_hours, 
        work_location, 
        profile_image, 
        created_at
    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING *;
    """

    values = (
        item_form_data.tenant_id, 
        item_form_data.company_id,
        item_form_data.designation_id,
        item_form_data.team_id,        
        item_form_data.first_name, 
        item_form_data.last_name, 
        item_form_data.manager, 
        item_form_data.function_group, 
        item_form_data.contact_number, 
        item_form_data.time_zone, 
        item_form_data.email, 
        item_form_data.working_hours, 
        item_form_data.work_location, 
        item_form_data.profile_image, 
        item_form_data.created_at
    )

    cursor.execute(query, values)
    new_item = cursor.fetchone()

   
    conn.commit()
    conn.close()

    if new_item:
        return PrimaryContactsSingleRecord(
            primary_contacts_id=new_item[0],
            tenant_id=new_item[1],
            company_id=new_item[2],
            designation_id=new_item[3],
            team_id=new_item[4],
            first_name=new_item[5],
            last_name=new_item[6],
            manager=new_item[7],
            function_group=new_item[8],
            contact_number=new_item[9],
            time_zone=new_item[10],
            email=new_item[11],
            working_hours=new_item[12],
            work_location=new_item[13],
            profile_image=new_item[14],
            created_at=new_item[15]
        )
    else:
        raise HTTPException(status_code=404, detail="Primary Contacts Detail creation failed")


def get_all_primary_contacts(tenant_id: int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT p.*,
            c.company_name, d.title as designation_title, t.team_title
            FROM primary_contacts p
            LEFT JOIN company c ON c.company_id=p.company_id
            LEFT JOIN designation d ON d.designation_id=p.designation_id
            LEFT JOIN team t ON t.team_id=p.team_id
        WHERE p.tenant_id = %s
        ORDER BY p.created_at DESC;
        """

    cursor.execute(query,(tenant_id, ))
    query_all_items = cursor.fetchall()

    conn.close()
    return [
        PrimaryContacts(
            primary_contacts_id=row[0],
            tenant_id=row[1],
            company_id=row[2],
            designation_id=row[3],
            team_id=row[4],
            first_name=row[5],
            last_name=row[6],
            manager=row[7],
            function_group=row[8],
            contact_number=row[9],            
            time_zone=row[10],
            email=row[11],
            working_hours=row[12],
            work_location=row[13],
            profile_image=row[14],
            created_at=row[15],
            company_name=row[16],
            designation_title=row[17],
            team_title=row[18]
        )
        for row in query_all_items
    ]


def update_primary_contacts(primary_contacts_id: int,  item_form_data: PrimaryContactsSingleRecord) -> Optional[PrimaryContactsSingleRecord]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
    UPDATE primary_contacts SET 
        company_id = %s, 
        designation_id = %s, 
        team_id = %s,
        first_name = %s, 
        last_name = %s, 
        manager = %s, 
        function_group = %s, 
        contact_number = %s, 
        time_zone = %s, 
        email = %s, 
        working_hours = %s, 
        work_location = %s, 
        profile_image = %s       
    WHERE primary_contacts_id = %s RETURNING *;
    """

    values = (
        item_form_data.company_id, 
        item_form_data.designation_id, 
        item_form_data.team_id,         
        item_form_data.first_name, 
        item_form_data.last_name, 
        item_form_data.manager, 
        item_form_data.function_group, 
        item_form_data.contact_number, 
        item_form_data.time_zone, 
        item_form_data.email, 
        item_form_data.working_hours, 
        item_form_data.work_location, 
        item_form_data.profile_image, 
        primary_contacts_id
    )

    cursor.execute(query, values)
    updated_itemm = cursor.fetchone()

    
    conn.commit()
    conn.close()

    if updated_itemm:
        return PrimaryContactsSingleRecord(
            primary_contacts_id=updated_itemm[0],
            tenant_id=updated_itemm[1],
            company_id=updated_itemm[2],
            designation_id=updated_itemm[3],
            team_id=updated_itemm[4],
            first_name=updated_itemm[5],
            last_name=updated_itemm[6],
            manager=updated_itemm[7],
            function_group=updated_itemm[8],
            contact_number=updated_itemm[9],            
            time_zone=updated_itemm[10],
            email=updated_itemm[11],
            working_hours=updated_itemm[12],
            work_location=updated_itemm[13],
            profile_image=updated_itemm[14],
            created_at=updated_itemm[15]
        )
    else:
        raise HTTPException(status_code=404, detail="Primary Contacts update failed")


def delete_primary_contacts(primary_contacts_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM primary_contacts WHERE primary_contacts_id = %s RETURNING primary_contacts_id;"
    cursor.execute(query, (primary_contacts_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False

def delete_all_primary_contacts(tenant_id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = "DELETE FROM primary_contacts WHERE tenant_id = %s RETURNING primary_contacts_id;"
    cursor.execute(query, (tenant_id,))
    deleted_item = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_item:
        return True
    else:
        return False


def get_primary_contacts_by_id(primary_contacts_id: int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT p.*,
            c.company_name, d.title as designation_title, t.team_title
            FROM primary_contacts p
            LEFT JOIN company c ON c.company_id=p.company_id
            LEFT JOIN designation d ON d.designation_id=p.designation_id
            LEFT JOIN team t ON t.team_id=p.team_id
        WHERE p.primary_contacts_id = %s
        ORDER BY p.created_at DESC;
        """

    cursor.execute(query, (primary_contacts_id,))
    get_item = cursor.fetchone()

    conn.close()

    if get_item:
        return  PrimaryContacts (
                    primary_contacts_id=get_item[0],
                    tenant_id=get_item[1],
                    company_id=get_item[2],
                    designation_id=get_item[3],
                    team_id=get_item[4],
                    first_name=get_item[5],
                    last_name=get_item[6],
                    manager=get_item[7],
                    function_group=get_item[8],
                    contact_number=get_item[9], 
                    time_zone=get_item[10],
                    email=get_item[11],
                    working_hours=get_item[12],
                    work_location=get_item[13],
                    profile_image=get_item[14],
                    created_at=get_item[15],
                    company_name=get_item[16],
                    designation_title=get_item[17],
                    team_title=get_item[18]
            )                    


def get_primary_contacts_by_manager(tenant_id: int, manager_name : str) :
    conn = get_db_connection()
    cursor = conn.cursor()
    
    manager_name = re.sub(r'-', ' ', manager_name)

    query = """
        SELECT p.*,
            c.company_name, d.title as designation_title, t.team_title
            FROM primary_contacts p
            LEFT JOIN company c ON c.company_id=p.company_id
            LEFT JOIN designation d ON d.designation_id=p.designation_id
            LEFT JOIN team t ON t.team_id=p.team_id
        WHERE p.tenant_id = %s AND lower(p.manager) = %s
        ORDER BY p.created_at DESC;
        """

    cursor.execute(query, (tenant_id, manager_name.lower()))
    get_item = cursor.fetchall()

    conn.close()

    if get_item:
        return [
            PrimaryContacts (
                primary_contacts_id=row[0],
                tenant_id=row[1],
                company_id=row[2],
                designation_id=row[3],
                team_id=row[4],
                first_name=row[5],
                last_name=row[6],
                manager=row[7],
                function_group=row[8],
                contact_number=row[9], 
                time_zone=row[10],
                email=row[11],
                working_hours=row[12],
                work_location=row[13],
                profile_image=row[14],
                created_at=row[15],
                company_name=row[16],
                designation_title=row[17],
                team_title=row[18]
            )
            for row in get_item
        ]
    

    
def get_primary_contacts_by_team(tenant_id: int, team_id : int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT p.*,
            c.company_name, d.title as designation_title, t.team_title
            FROM primary_contacts p
            LEFT JOIN company c ON c.company_id=p.company_id
            LEFT JOIN designation d ON d.designation_id=p.designation_id
            LEFT JOIN team t ON t.team_id=p.team_id
        WHERE p.tenant_id = %s AND p.team_id = %s
        ORDER BY p.created_at DESC;
        """

    cursor.execute(query, (tenant_id, team_id))
    get_item = cursor.fetchall()

    conn.close()

    if get_item:
        return [
            PrimaryContacts (
                primary_contacts_id=row[0],
                tenant_id=row[1],
                company_id=row[2],
                designation_id=row[3],
                team_id=row[4],
                first_name=row[5],
                last_name=row[6],
                manager=row[7],
                function_group=row[8],
                contact_number=row[9], 
                time_zone=row[10],
                email=row[11],
                working_hours=row[12],
                work_location=row[13],
                profile_image=row[14],
                created_at=row[15],
                company_name=row[16],
                designation_title=row[17],
                team_title=row[18]
            )
            for row in get_item
        ]



def get_primary_contacts_by_company(tenant_id: int, company_id : int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT p.*,
            c.company_name, d.title as designation_title, t.team_title
            FROM primary_contacts p
            LEFT JOIN company c ON c.company_id=p.company_id
            LEFT JOIN designation d ON d.designation_id=p.designation_id
            LEFT JOIN team t ON t.team_id=p.team_id
        WHERE p.tenant_id = %s AND p.company_id = %s
        ORDER BY p.created_at DESC;
        """

    cursor.execute(query, (tenant_id, company_id))
    get_item = cursor.fetchall()

    conn.close()

    if get_item:
        return [
            PrimaryContacts (
                primary_contacts_id=row[0],
                tenant_id=row[1],
                company_id=row[2],
                designation_id=row[3],
                team_id=row[4],
                first_name=row[5],
                last_name=row[6],
                manager=row[7],
                function_group=row[8],
                contact_number=row[9], 
                time_zone=row[10],
                email=row[11],
                working_hours=row[12],
                work_location=row[13],
                profile_image=row[14],
                created_at=row[15],
                company_name=row[16],
                designation_title=row[17],
                team_title=row[18]
            )
            for row in get_item
        ]
