from typing import List, Optional
from datetime import date, datetime
from .schemas import Rfx, RfxCreate, RfxGet 
from .schemas import RfxUpdateBidOwner, RfxUpdateRfxOwner, RfxUpdateBidNumber, RfxUpdateRfxNumber
from .schemas import RfxUpdateBidStatus, RfxUpdateRfxStatus, RFxGetMax
from db.connection import get_db_connection

# Function to create an RFX
def create_rfx(rfx_data: RfxCreate) -> Optional[Rfx]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        INSERT INTO rfx(
        tenant_id, opportunity_id, rfx_number, rfx_id, rfx_title, rfx_record_type, prev_rfx_reference, 
        rfx_type, bid_type, bid_validity, bid_submission_mode, submission_contents, work_agreement_ref_num, 
        rfx_tech_contact_id, rfx_comm_contact_id, submission_instructions, visit_worksite, 
        visit_worksite_instructions, issue_date, due_date, tech_clarif_deadline, comm_clarif_deadline, 
        expected_award_date, bid_number, rfx_status, bid_status, data, rfx_owner_id, bid_owner_id, created_by, 
        is_active, created_at, updated_at)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        RETURNING *;
        """

    cursor.execute(query, (
        rfx_data.tenant_id, rfx_data.opportunity_id, rfx_data.rfx_number, rfx_data.rfx_id, rfx_data.rfx_title, 
        rfx_data.rfx_record_type, rfx_data.prev_rfx_reference, rfx_data.rfx_type, rfx_data.bid_type, 
        rfx_data.bid_validity, rfx_data.bid_submission_mode, rfx_data.submission_contents, 
        rfx_data.work_agreement_ref_num, rfx_data.rfx_tech_contact_id, rfx_data.rfx_comm_contact_id, 
        rfx_data.submission_instructions, rfx_data.visit_worksite, rfx_data.visit_worksite_instructions, 
        rfx_data.issue_date, rfx_data.due_date, rfx_data.tech_clarif_deadline, rfx_data.comm_clarif_deadline, 
        rfx_data.expected_award_date, rfx_data.bid_number, rfx_data.rfx_status, rfx_data.bid_status, rfx_data.data, 
        rfx_data.rfx_owner_id, rfx_data.bid_owner_id, rfx_data.created_by, rfx_data.is_active, 
        rfx_data.created_at, rfx_data.updated_at)
    )
    rfx = cursor.fetchone()               
    conn.commit()
    conn.close()
   
    if rfx:
        return Rfx(
            id=rfx[0],
            tenant_id=rfx[1],
            opportunity_id=rfx[2],
            rfx_number=rfx[3],
            rfx_id=rfx[4],	
            rfx_title=rfx[5],
            rfx_record_type=rfx[6],
            prev_rfx_reference=rfx[7],
            rfx_type=rfx[8],
            bid_type=rfx[9],
            bid_validity=rfx[10],
            bid_submission_mode=rfx[11],
            submission_contents=rfx[12],
            work_agreement_ref_num=rfx[13],
            rfx_tech_contact_id=rfx[14],
            rfx_comm_contact_id=rfx[15],
            submission_instructions=rfx[16],
            visit_worksite=rfx[17],
            visit_worksite_instructions=rfx[18],
            issue_date=rfx[19],
            due_date=rfx[20],
            tech_clarif_deadline=rfx[21],
            comm_clarif_deadline=rfx[22],
            expected_award_date=rfx[23],
            bid_number=rfx[24],
            rfx_status=rfx[25],
            bid_status=rfx[26],
            data=rfx[27],
            rfx_owner_id=rfx[28],
            bid_owner_id=rfx[29],
            created_by=rfx[30],
            is_active=rfx[31],
            created_at=rfx[32],
            updated_at=rfx[33]
        ) 
        
    else:
        return None 



# Function to get all RFX
def get_all_rfx(tenant_id: int, searchTerm: str, offset: int, limit: int) :
    conn = get_db_connection()
    cursor = conn.cursor()

    if searchTerm:
        searchTerm = '%' + searchTerm.lower() + '%'
        query = """
        SELECT r.*,
            CONCAT(uc.first_name, ' ', uc.last_name) AS creator_name, 
            uc.email AS creator_email, uc.profile_image as creator_image, uc.job_title AS creator_jobtitle,
            CONCAT(ur.first_name, ' ', ur.last_name) AS rfxowner_name, 
            ur.email AS rfxowner_email, ur.profile_image as rfxowner_image, ur.job_title AS rfxowner_jobtitle,
            CONCAT(ut.first_name, ' ', ut.last_name) AS rfxtech_contact_name,
            CONCAT(uo.first_name, ' ', uo.last_name) AS rfxcomm_contact_name,
            o.opp_title, o.opp_number,
            a.account_name AS enduser_name, aa.account_name AS customer_name
        FROM rfx r
            LEFT JOIN users uc ON uc.user_id = r.created_by
            LEFT JOIN users ur ON ur.user_id = r.rfx_owner_id
            LEFT JOIN users ut ON ut.user_id = r.rfx_tech_contact_id
            LEFT JOIN users uo ON uo.user_id = r.rfx_comm_contact_id
            LEFT JOIN opportunity o ON o.opportunity_id = r.opportunity_id
            LEFT JOIN account a ON a.account_id = o.enduser_id 
            LEFT JOIN account aa ON aa.account_id = o.customer_id
        WHERE r.tenant_id = %s AND (lower(r.rfx_title) LIKE %s OR lower(r.rfx_id) LIKE %s)
        ORDER BY r.created_at DESC
        OFFSET %s LIMIT %s;
        """
        cursor.execute(query, (tenant_id, searchTerm, searchTerm, offset, limit))
        rfxs = cursor.fetchall()
    else:
        query = """
        SELECT r.*,
            CONCAT(uc.first_name, ' ', uc.last_name) AS creator_name, 
            uc.email AS creator_email, uc.profile_image as creator_image, uc.job_title AS creator_jobtitle,
            CONCAT(ur.first_name, ' ', ur.last_name) AS rfxowner_name, 
            ur.email AS rfxowner_email, ur.profile_image as rfxowner_image, ur.job_title AS rfxowner_jobtitle,
            CONCAT(ut.first_name, ' ', ut.last_name) AS rfxtech_contact_name,
            CONCAT(uo.first_name, ' ', uo.last_name) AS rfxcomm_contact_name,
            o.opp_title, o.opp_number,
            a.account_name AS enduser_name, aa.account_name AS customer_name
        FROM rfx r
            LEFT JOIN users uc ON uc.user_id = r.created_by
            LEFT JOIN users ur ON ur.user_id = r.rfx_owner_id
            LEFT JOIN users ut ON ut.user_id = r.rfx_tech_contact_id
            LEFT JOIN users uo ON uo.user_id = r.rfx_comm_contact_id
            LEFT JOIN opportunity o ON o.opportunity_id = r.opportunity_id
            LEFT JOIN account a ON a.account_id = o.enduser_id 
            LEFT JOIN account aa ON aa.account_id = o.customer_id
        WHERE r.tenant_id = %s 
        ORDER BY r.created_at DESC
        OFFSET %s LIMIT %s;
        """
        cursor.execute(query, (tenant_id, offset, limit))
        rfxs = cursor.fetchall()
                
    # Query to get total count without offset and limit
    query_total_count = "SELECT COUNT(*) FROM rfx WHERE tenant_id = %s;"
    cursor.execute(query_total_count, (tenant_id, ))
    total_count = cursor.fetchone()    
    conn.close()
    
    if rfxs:
        return {
            "data": [
                RfxGet(
                    id=row[0],
                    tenant_id=row[1],
                    opportunity_id=row[2],
                    rfx_number=row[3],
                    rfx_id=row[4],	
                    rfx_title=row[5],
                    rfx_record_type=row[6],
                    prev_rfx_reference=row[7],
                    rfx_type=row[8],
                    bid_type=row[9],
                    bid_validity=row[10],
                    bid_submission_mode=row[11],
                    submission_contents=row[12],
                    work_agreement_ref_num=row[13],
                    rfx_tech_contact_id=row[14],
                    rfx_comm_contact_id=row[15],
                    submission_instructions=row[16],
                    visit_worksite=row[17],
                    visit_worksite_instructions=row[18],
                    issue_date=row[19],
                    due_date=row[20],
                    tech_clarif_deadline=row[21],
                    comm_clarif_deadline=row[22],
                    expected_award_date=row[23],
                    bid_number=row[24],
                    rfx_status=row[25],
                    bid_status=row[26],
                    data=row[27],
                    rfx_owner_id=row[28],
                    bid_owner_id=row[29],
                    created_by=row[30],
                    is_active=row[31],
                    created_at=row[32],
                    updated_at=row[33],
                    creator_name=row[34],
                    creator_email=row[35],
                    creator_image=row[36],
                    creator_jobtitle=row[37],
                    rfxowner_name=row[38],
                    rfxowner_email=row[39],
                    rfxowner_image=row[40],
                    rfxowner_jobtitle=row[41],
                    rfxtech_contact_name=row[42],
                    rfxcomm_contact_name=row[43],
                    opp_title=row[44],
                    opp_number=row[45],
                    enduser_name=row[46],
                    customer_name=row[47]
                )
                for row in rfxs
            ],
            "total_count": total_count
        }
    else:
        None

 
 # update an rfx record by ID
def update_rfx(id: int, rfx_data: RfxCreate) -> Optional[Rfx]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE rfx SET
        rfx_number = %s, 
        rfx_id = %s, 
        rfx_title = %s, 
        rfx_record_type = %s, 
        prev_rfx_reference = %s, 
        rfx_type = %s, 
        bid_type = %s, 
        bid_validity = %s, 
        bid_submission_mode = %s, 
        submission_contents = %s, 
        work_agreement_ref_num = %s, 
        rfx_tech_contact_id = %s, 
        rfx_comm_contact_id = %s, 
        submission_instructions = %s, 
        visit_worksite = %s, 
        visit_worksite_instructions = %s, 
        issue_date = %s, 
        due_date = %s, 
        tech_clarif_deadline = %s, 
        comm_clarif_deadline = %s, 
        expected_award_date = %s, 
        bid_number = %s, 
        rfx_status = %s, 
        bid_status = %s, 
        data = %s, 
        rfx_owner_id = %s, 
        bid_owner_id = %s, 
        is_active = %s, 
        updated_at = %s        
            WHERE id = %s
        RETURNING *;
        """

    values = (
        rfx_data.rfx_number, 
        rfx_data.rfx_id, 
        rfx_data.rfx_title, 
        rfx_data.rfx_record_type, 
        rfx_data.prev_rfx_reference, 
        rfx_data.rfx_type, 
        rfx_data.bid_type, 
        rfx_data.bid_validity, 
        rfx_data.bid_submission_mode, 
        rfx_data.submission_contents, 
        rfx_data.work_agreement_ref_num, 
        rfx_data.rfx_tech_contact_id, 
        rfx_data.rfx_comm_contact_id, 
        rfx_data.submission_instructions, 
        rfx_data.visit_worksite, 
        rfx_data.visit_worksite_instructions, 
        rfx_data.issue_date, 
        rfx_data.due_date, 
        rfx_data.tech_clarif_deadline, 
        rfx_data.comm_clarif_deadline, 
        rfx_data.expected_award_date, 
        rfx_data.bid_number, 
        rfx_data.rfx_status, 
        rfx_data.bid_status, 
        rfx_data.data, 
        rfx_data.rfx_owner_id, 
        rfx_data.bid_owner_id, 
        rfx_data.is_active, 
        rfx_data.updated_at,
        id        
    )           
    cursor.execute(query, values)
    update_rfx = cursor.fetchone()                       
    conn.commit()
    conn.close()
    
    if update_rfx:
        return Rfx(
            id=update_rfx[0],
            tenant_id=update_rfx[1],
            opportunity_id=update_rfx[2],
            rfx_number=update_rfx[3],
            rfx_id=update_rfx[4],	
            rfx_title=update_rfx[5],
            rfx_record_type=update_rfx[6],
            prev_rfx_reference=update_rfx[7],
            rfx_type=update_rfx[8],
            bid_type=update_rfx[9],
            bid_validity=update_rfx[10],
            bid_submission_mode=update_rfx[11],
            submission_contents=update_rfx[12],
            work_agreement_ref_num=update_rfx[13],
            rfx_tech_contact_id=update_rfx[14],
            rfx_comm_contact_id=update_rfx[15],
            submission_instructions=update_rfx[16],
            visit_worksite=update_rfx[17],
            visit_worksite_instructions=update_rfx[18],
            issue_date=update_rfx[19],
            due_date=update_rfx[20],
            tech_clarif_deadline=update_rfx[21],
            comm_clarif_deadline=update_rfx[22],
            expected_award_date=update_rfx[23],
            bid_number=update_rfx[24],
            rfx_status=update_rfx[25],
            bid_status=update_rfx[26],
            data=update_rfx[27],
            rfx_owner_id=update_rfx[28],
            bid_owner_id=update_rfx[29],
            created_by=update_rfx[30],
            is_active=update_rfx[31],
            created_at=update_rfx[32],
            updated_at=update_rfx[33]
        )
    else:
        return None


def update_rfx_number(rfx_id: int, rfx_data: RfxUpdateRfxNumber) -> Optional[bool]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE rfx SET
            rfx_number = %s, 
            updated_at = %s   
            WHERE rfx_id = %s
        RETURNING *;
        """
    values = (
        rfx_data.rfx_number,
        rfx_data.updated_at,
        rfx_id        
    )        
   
    cursor.execute(query, values)
    updated_rfx = cursor.fetchone()
                
    conn.commit()
    conn.close()
    
    if updated_rfx:
        return True
    else:
        return False


def update_bid_number(rfx_id: int, rfx_data: RfxUpdateBidNumber) -> Optional[bool]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE rfx SET 
            bid_number = %s,
            updated_at = %s    
            WHERE rfx_id = %s
        RETURNING *;
        """
    values = (
        rfx_data.bid_number,
        rfx_data.updated_at,
        rfx_id        
    )        
   
    cursor.execute(query, values)
    updated_rfx = cursor.fetchone()
                
    conn.commit()
    conn.close()
    
    if updated_rfx:
        return True
    else:
        return False


def update_bid_owner(rfx_id: int, rfx_data: RfxUpdateBidOwner) -> Optional[bool]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE rfx SET
            bid_owner_id = %s  
            updated_at = %s  
            WHERE rfx_id = %s
        RETURNING *;
        """
    values = (
        rfx_data.bid_owner_id,
        rfx_data.updated_at,
        rfx_id        
    )        
   
    cursor.execute(query, values)
    updated_rfx = cursor.fetchone()
                
    conn.commit()
    conn.close()
    
    if updated_rfx:
        return True
    else:
        return False

def update_rfx_owner(rfx_id: int, rfx_data: RfxUpdateRfxOwner) -> Optional[bool]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE rfx SET
            rfx_owner_id = %s  
            updated_at = %s  
            WHERE rfx_id = %s
        RETURNING *;
        """
    values = (
        rfx_data.rfx_owner_id,
        rfx_data.updated_at,
        rfx_id        
    )        
   
    cursor.execute(query, values)
    updated_rfx = cursor.fetchone()
                
    conn.commit() 
    conn.close()
    
    if updated_rfx:
        return True
    else:
        return False

def update_bid_status(rfx_id: int, status: str, rfx_data: RfxUpdateBidStatus) -> Optional[bool]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE rfx SET
            bid_status = %s,
            updated_at = %s,    
            WHERE rfx_id = %s
        RETURNING *;
        """
    values = (
        rfx_data.bid_status,
        rfx_data.updated_at,
        rfx_id        
    )        
   
    cursor.execute(query, values)
    updated_rfx = cursor.fetchone()                
    conn.commit()
    conn.close()
    
    if updated_rfx:
        return True
    else:
        return False


def update_rfx_status(rfx_id: int, status: str, rfx_data: RfxUpdateRfxStatus) -> Optional[bool]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        UPDATE rfx SET
            rfx_status = %s,
            updated_at = %s,    
            WHERE rfx_id = %s
        RETURNING *;
        """
    values = (
        rfx_data.rfx_status,
        rfx_data.updated_at,
        rfx_id        
    )        
   
    cursor.execute(query, values)
    updated_rfx = cursor.fetchone()                
    conn.commit()
    conn.close()
    
    if updated_rfx:
        return True
    else:
        return False
  
    
def delete_rfx(id: int) -> bool:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = "DELETE FROM rfx WHERE id = %s RETURNING id;"
    cursor.execute(query, (id,))
    deleted_rfx = cursor.fetchone()

    conn.commit()
    conn.close()

    if deleted_rfx:
        return True
    else:
        return False 

# Function to retrieve an RFX by ID
def get_rfx_by_id(rfx_id: int) -> Optional[RfxGet]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT r.*,
            CONCAT(uc.first_name, ' ', uc.last_name) AS creator_name, 
            uc.email AS creator_email, uc.profile_image as creator_image, uc.job_title AS creator_jobtitle,
            CONCAT(ur.first_name, ' ', ur.last_name) AS rfxowner_name, 
            ur.email AS rfxowner_email, ur.profile_image as rfxowner_image, ur.job_title AS rfxowner_jobtitle,
            CONCAT(ut.first_name, ' ', ut.last_name) AS rfxtech_contact_name,
            CONCAT(uo.first_name, ' ', uo.last_name) AS rfxcomm_contact_name,
            o.opp_title, o.opp_number,
            a.account_name AS enduser_name, aa.account_name AS customer_name
        FROM rfx r
            LEFT JOIN users uc ON uc.user_id = r.created_by
            LEFT JOIN users ur ON ur.user_id = r.rfx_owner_id
            LEFT JOIN users ut ON ut.user_id = r.rfx_tech_contact_id
            LEFT JOIN users uo ON uo.user_id = r.rfx_comm_contact_id
            LEFT JOIN opportunity o ON o.opportunity_id = r.opportunity_id
            LEFT JOIN account a ON a.account_id = o.enduser_id 
            LEFT JOIN account aa ON aa.account_id = o.customer_id
        WHERE  r.id = %s
        ORDER BY r.created_at DESC;
        """
    cursor.execute(query, (rfx_id,))
    rfx = cursor.fetchone()
    conn.close()

    if rfx:
        return RfxGet(
            id=rfx[0],
            tenant_id=rfx[1],
            opportunity_id=rfx[2],
            rfx_number=rfx[3],
            rfx_id=rfx[4],	
            rfx_title=rfx[5],
            rfx_record_type=rfx[6],
            prev_rfx_reference=rfx[7],
            rfx_type=rfx[8],
            bid_type=rfx[9],
            bid_validity=rfx[10],
            bid_submission_mode=rfx[11],
            submission_contents=rfx[12],
            work_agreement_ref_num=rfx[13],
            rfx_tech_contact_id=rfx[14],
            rfx_comm_contact_id=rfx[15],
            submission_instructions=rfx[16],
            visit_worksite=rfx[17],
            visit_worksite_instructions=rfx[18],
            issue_date=rfx[19],
            due_date=rfx[20],
            tech_clarif_deadline=rfx[21],
            comm_clarif_deadline=rfx[22],
            expected_award_date=rfx[23],
            bid_number=rfx[24],
            rfx_status=rfx[25],
            bid_status=rfx[26],
            data=rfx[27],
            rfx_owner_id=rfx[28],
            bid_owner_id=rfx[29],
            created_by=rfx[30],
            is_active=rfx[31],
            created_at=rfx[32],
            updated_at=rfx[33],
            creator_name=rfx[34],
            creator_email=rfx[35],
            creator_image=rfx[36],
            creator_jobtitle=rfx[37],
            rfxowner_name=rfx[38],
            rfxowner_email=rfx[39],
            rfxowner_image=rfx[40],
            rfxowner_jobtitle=rfx[41],
            rfxtech_contact_name=rfx[42],
            rfxcomm_contact_name=rfx[43],                   
            opp_title=rfx[44],
            opp_number=rfx[45],
            enduser_name=rfx[46],
            customer_name=rfx[47]
        )
    else:
        return None
   
    
def get_rfx_by_rfx_owner_id(tenant_id: int, rfx_owner_id: int) -> List[RfxGet]:
    conn = get_db_connection()
    cursor = conn.cursor()
   
    query = """
        SELECT r.*,
            CONCAT(uc.first_name, ' ', uc.last_name) AS creator_name, 
            uc.email AS creator_email, uc.profile_image as creator_image, uc.job_title AS creator_jobtitle,
            CONCAT(ur.first_name, ' ', ur.last_name) AS rfxowner_name, 
            ur.email AS rfxowner_email, ur.profile_image as rfxowner_image, ur.job_title AS rfxowner_jobtitle,
            CONCAT(ut.first_name, ' ', ut.last_name) AS rfxtech_contact_name,
            CONCAT(uo.first_name, ' ', uo.last_name) AS rfxcomm_contact_name,
            o.opp_title, o.opp_number,
            a.account_name AS enduser_name, aa.account_name AS customer_name
        FROM rfx r
            LEFT JOIN users uc ON uc.user_id = r.created_by
            LEFT JOIN users ur ON ur.user_id = r.rfx_owner_id
            LEFT JOIN users ut ON ut.user_id = r.rfx_tech_contact_id
            LEFT JOIN users uo ON uo.user_id = r.rfx_comm_contact_id
            LEFT JOIN opportunity o ON o.opportunity_id = r.opportunity_id
            LEFT JOIN account a ON a.account_id = o.enduser_id 
            LEFT JOIN account aa ON aa.account_id = o.customer_id
        WHERE r.rfx_owner_id = %s AND r.tenant_id = %s
        ORDER BY r.created_at DESC;
        """
    
                
    cursor.execute(query, (rfx_owner_id, tenant_id))
    rfxs = cursor.fetchall()

    conn.close()

    return [
        RfxGet(
            id=rfxs[0],
            tenant_id=rfxs[1],
            opportunity_id=rfxs[2],
            rfx_number=rfxs[3],
            rfx_id=rfxs[4],	
            rfx_title=rfxs[5],
            rfx_record_type=rfxs[6],
            prev_rfx_reference=rfxs[7],
            rfx_type=rfxs[8],
            bid_type=rfxs[9],
            bid_validity=rfxs[10],
            bid_submission_mode=rfxs[11],
            submission_contents=rfxs[12],
            work_agreement_ref_num=rfxs[13],
            rfx_tech_contact_id=rfxs[14],
            rfx_comm_contact_id=rfxs[15],
            submission_instructions=rfxs[16],
            visit_worksite=rfxs[17],
            visit_worksite_instructions=rfxs[18],
            issue_date=rfxs[19],
            due_date=rfxs[20],
            tech_clarif_deadline=rfxs[21],
            comm_clarif_deadline=rfxs[22],
            expected_award_date=rfxs[23],
            bid_number=rfxs[24],
            rfx_status=rfxs[25],
            bid_status=rfxs[26],
            data=rfxs[27],
            rfx_owner_id=rfxs[28],
            bid_owner_id=rfxs[29],
            created_by=rfxs[30],
            is_active=rfxs[31],
            created_at=rfxs[32],
            updated_at=rfxs[33],
            creator_name=rfxs[34],
            creator_email=rfxs[35],
            creator_image=rfxs[36],
            creator_jobtitle=rfxs[37],
            rfxowner_name=rfxs[38],
            rfxowner_email=rfxs[39],
            rfxowner_image=rfxs[40],
            rfxowner_jobtitle=rfxs[41],
            rfxtech_contact_name=rfxs[42],
            rfxcomm_contact_name=rfxs[43],                   
            opp_title=rfxs[44],
            opp_number=rfxs[45],
            enduser_name=rfxs[46],
            customer_name=rfxs[47]
        )
        for row in rfxs
    ]



# Function to retrieve RFXs by rfx number
def get_rfx_by_rfx_number(tenant_id: int, rfx_number: str) ->  List[RfxGet]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT r.*,
            CONCAT(uc.first_name, ' ', uc.last_name) AS creator_name, 
            uc.email AS creator_email, uc.profile_image as creator_image, uc.job_title AS creator_jobtitle,
            CONCAT(ur.first_name, ' ', ur.last_name) AS rfxowner_name, 
            ur.email AS rfxowner_email, ur.profile_image as rfxowner_image, ur.job_title AS rfxowner_jobtitle,
            CONCAT(ut.first_name, ' ', ut.last_name) AS rfxtech_contact_name,
            CONCAT(uo.first_name, ' ', uo.last_name) AS rfxcomm_contact_name,
            o.opp_title, o.opp_number,
            a.account_name AS enduser_name, aa.account_name AS customer_name
        FROM rfx r
            LEFT JOIN users uc ON uc.user_id = r.created_by
            LEFT JOIN users ur ON ur.user_id = r.rfx_owner_id
            LEFT JOIN users ut ON ut.user_id = r.rfx_tech_contact_id
            LEFT JOIN users uo ON uo.user_id = r.rfx_comm_contact_id
            LEFT JOIN opportunity o ON o.opportunity_id = r.opportunity_id
            LEFT JOIN account a ON a.account_id = o.enduser_id 
            LEFT JOIN account aa ON aa.account_id = o.customer_id
        WHERE lower(r.rfx_number) = %s AND r.tenant_id=%s
        ORDER BY r.created_at DESC        
        """
    
    try:
        cursor.execute(query, (rfx_number.lower(), tenant_id,))
        rfxs = cursor.fetchall()        
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
            
    return [
        RfxGet(
            id=row[0],
            tenant_id=row[1],
            opportunity_id=row[2],
            rfx_number=row[3],
            rfx_id=row[4],	
            rfx_title=row[5],
            rfx_record_type=row[6],
            prev_rfx_reference=row[7],
            rfx_type=row[8],
            bid_type=row[9],
            bid_validity=row[10],
            bid_submission_mode=row[11],
            submission_contents=row[12],
            work_agreement_ref_num=row[13],
            rfx_tech_contact_id=row[14],
            rfx_comm_contact_id=row[15],
            submission_instructions=row[16],
            visit_worksite=row[17],
            visit_worksite_instructions=row[18],
            issue_date=row[19],
            due_date=row[20],
            tech_clarif_deadline=row[21],
            comm_clarif_deadline=row[22],
            expected_award_date=row[23],
            bid_number=row[24],
            rfx_status=row[25],
            bid_status=row[26],
            data=row[27],
            rfx_owner_id=row[28],
            bid_owner_id=row[29],
            created_by=row[30],
            is_active=row[31],
            created_at=row[32],
            updated_at=row[33],
            creator_name=row[34],
            creator_email=row[35],
            creator_image=row[36],
            creator_jobtitle=row[37],
            rfxowner_name=row[38],
            rfxowner_email=row[39],
            rfxowner_image=row[40],
            rfxowner_jobtitle=row[41],
            rfxtech_contact_name=row[42],
            rfxcomm_contact_name=row[43],                   
            opp_title=row[44],
            opp_number=row[45],
            enduser_name=row[46],
            customer_name=row[47]
        ) 
        for row in rfxs
    ]



# Function to retrieve RFX by OPP ID
def get_rfx_by_opportunity_id(opportunity_id: int) -> List[RfxGet]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT r.*,
            CONCAT(uc.first_name, ' ', uc.last_name) AS creator_name, 
            uc.email AS creator_email, uc.profile_image as creator_image, uc.job_title AS creator_jobtitle,
            CONCAT(ur.first_name, ' ', ur.last_name) AS rfxowner_name, 
            ur.email AS rfxowner_email, ur.profile_image as rfxowner_image, ur.job_title AS rfxowner_jobtitle,
            CONCAT(ut.first_name, ' ', ut.last_name) AS rfxtech_contact_name,
            CONCAT(uo.first_name, ' ', uo.last_name) AS rfxcomm_contact_name,
            o.opp_title, o.opp_number,
            a.account_name AS enduser_name, aa.account_name AS customer_name
        FROM rfx r
            LEFT JOIN users uc ON uc.user_id = r.created_by
            LEFT JOIN users ur ON ur.user_id = r.rfx_owner_id
            LEFT JOIN users ut ON ut.user_id = r.rfx_tech_contact_id
            LEFT JOIN users uo ON uo.user_id = r.rfx_comm_contact_id
            LEFT JOIN opportunity o ON o.opportunity_id = r.opportunity_id
            LEFT JOIN account a ON a.account_id = o.enduser_id 
            LEFT JOIN account aa ON aa.account_id = o.customer_id
        WHERE  r.opportunity_id = %s
        ORDER BY r.created_at DESC;
        """

    cursor.execute(query, (opportunity_id,))
    rfxs = cursor.fetchall()
    conn.close()

    if rfxs:
        return [
            RfxGet(
                id=rfx[0],
                tenant_id=rfx[1],
                opportunity_id=rfx[2],
                rfx_number=rfx[3],
                rfx_id=rfx[4],	
                rfx_title=rfx[5],
                rfx_record_type=rfx[6],
                prev_rfx_reference=rfx[7],
                rfx_type=rfx[8],
                bid_type=rfx[9],
                bid_validity=rfx[10],
                bid_submission_mode=rfx[11],
                submission_contents=rfx[12],
                work_agreement_ref_num=rfx[13],
                rfx_tech_contact_id=rfx[14],
                rfx_comm_contact_id=rfx[15],
                submission_instructions=rfx[16],
                visit_worksite=rfx[17],
                visit_worksite_instructions=rfx[18],
                issue_date=rfx[19],
                due_date=rfx[20],
                tech_clarif_deadline=rfx[21],
                comm_clarif_deadline=rfx[22],
                expected_award_date=rfx[23],
                bid_number=rfx[24],
                rfx_status=rfx[25],
                bid_status=rfx[26],
                data=rfx[27],
                rfx_owner_id=rfx[28],
                bid_owner_id=rfx[29],
                created_by=rfx[30],
                is_active=rfx[31],
                created_at=rfx[32],
                updated_at=rfx[33],
                creator_name=rfx[34],
                creator_email=rfx[35],
                creator_image=rfx[36],
                creator_jobtitle=rfx[37],
                rfxowner_name=rfx[38],
                rfxowner_email=rfx[39],
                rfxowner_image=rfx[40],
                rfxowner_jobtitle=rfx[41],
                rfxtech_contact_name=rfx[42],
                rfxcomm_contact_name=rfx[43],                   
                opp_title=rfx[44],
                opp_number=rfx[45],
                enduser_name=rfx[46],
                customer_name=rfx[47]
            ) 
            for rfx in rfxs
        ]
        
    else:
        return None
    

def get_rfx_id_max() -> Optional[RFxGetMax]:
    conn = get_db_connection()
    cursor = conn.cursor()

    query = """
        SELECT max(id), max(rfx_id) from rfx;
        """

    cursor.execute(query,)
    rfx = cursor.fetchone()    
    conn.close()
    
    if rfx:
        return RFxGetMax(
            id=rfx[0],
            rfx_id=rfx[1]
        )
    else:
        None