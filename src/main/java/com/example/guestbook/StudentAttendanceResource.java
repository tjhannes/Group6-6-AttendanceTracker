package com.example.guestbook;

import java.io.IOException;
import java.util.List;
import java.util.ListIterator;

import org.restlet.Request;
import org.restlet.Response;
import org.restlet.data.Form;
import org.restlet.data.Parameter;
import org.restlet.representation.Representation;
import org.restlet.resource.Get;
import org.restlet.resource.Post;
import org.restlet.resource.ResourceException;
import org.restlet.resource.ServerResource;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;

public class StudentAttendanceResource extends ServerResource 
{
	@Post
	public String takeAttendance(Representation entity) throws ResourceException
	{
		final Form form = new Form(entity);
		String student_id = null;
		String postText =  form.getFirstValue("data");
		String tutorCodeText = null;
		
		if(form.getFirstValue("token") != null) 
		{
			tutorCodeText = form.getFirstValue("token");
			
			if(tryParseInt(tutorCodeText))
			{
				int tutorCode = Integer.parseInt(tutorCodeText);
				if(tutorCode != 0000)
				{
					return "Tutor Code Inv";
				}
			}
			else
			{
				return "Tutor Code Inv";
			}
			
			int week_id = -1;		

			if(postText != null)
			{
				String items[] = postText.split("#");
				student_id = items[1];
				
				if(tryParseInt(items[0]))
				{
					week_id = Integer.parseInt(items[0]);
				}
				else
				{
					return "Invalid Token";
				}
				
				Student student = ObjectifyService.ofy().load().type(Student.class).parent(Key.create(Guestbook.class, "student")).id(student_id).now();
			  	if(student != null)
			  	{
			  		if(student.attendanceTokens[week_id].compareTo(postText) == 0)
			  		{
			  			Attendance attendance = new Attendance(student_id,student.group_id,week_id,true);
			  			ObjectifyService.ofy().save().entity(attendance).now();
			  		}
			  		else
			  		{
			  			return "Invalid Token";//token  wrong
			  		}
			  	}
			  	else //there is no student with the given student id
			  	{
			  		return "Wrong St. ID";//student id wrong
			  	}
			}
			else
			{
				return "POST Req. Err."; // message wrong
			}
		}
		
		return "Success!";
	}
	
	@Get
	public String sendAttendance()
	{
		String email = getQuery().getValues("email"); //TODO changed this with student ID after switching from Google API to GAE endpoints in android application
		int weekNumber = -1;
		
		if(tryParseInt(getQuery().getValues("weekNumber")))
		{
			weekNumber = Integer.parseInt(getQuery().getValues("weekNumber"));
		}
		
		List<Student> studentList = ObjectifyService.ofy()
	  	          .load()
	  	          .type(Student.class)
	  	          .ancestor(Key.create(Guestbook.class, "student"))
	  	          .order("-date")
	  	          .list();
		
		Student requestingStudent = null;
		for(Student st : studentList)
		{
			if(st.student_email.compareTo(email) == 0)
			{
				requestingStudent = st;
			}
		}
		
		if(requestingStudent != null)
		{
			if(weekNumber != -1) //student requests attendance token
			{
				return requestingStudent.attendanceTokens[weekNumber];
			}
			else //student requests his/her taken attendances
			{
				List<Attendance> attendanceList;
				attendanceList = ObjectifyService.ofy()
			              .load()
			              .type(Attendance.class)
			              .ancestor(Key.create(Guestbook.class, "attendance"))
			              .list();
				
				StringBuilder sb = new StringBuilder();
				for(Attendance attendance : attendanceList)
				{
					if(attendance.student_id.compareTo(requestingStudent.student_id) == 0)
					{
						sb.append("attendance_id: ");
						sb.append(attendance.id+"\n");
						sb.append("week_id: ");
						sb.append(attendance.week_id+"#");
					}
				}
				
				return sb.toString();
			}
		}	
		
        return "Student does not exist";
	}
	
	boolean tryParseInt(String value) 
	{  
	     try 
	     {  
	    	 Integer.parseInt(value);  
	         return true;  
	     } 
	     catch (NumberFormatException e) 
	     {  
	         return false;  
	     }  
	}
}