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

public class AttendanceResource extends ServerResource 
{	
	@Post
	public void takeAttendance(Representation entity) throws ResourceException
	{
		final Form form = new Form(entity);
		String student_id = form.getFirstValue("student_id");
		int group_id = -1;
		int week_id = -1;
		int tutor_code = -1;
		
		if(tryParseInt(form.getFirstValue("tutor_code")))
		{
			tutor_code = Integer.parseInt(form.getFirstValue("tutor_code"));
			
			if(tutor_code != 0000)
			{
	  			throw new ResourceException(404, "Invalid Tutor Code","");
			}
		}
		else
		{
  			throw new ResourceException(404, "Invalid Tutor Code Input","");
		}
		
		if(tryParseInt(form.getFirstValue("group_id")))
		{
			group_id = Integer.parseInt(form.getFirstValue("group_id"));
		}
		
		if(tryParseInt(form.getFirstValue("week_id")))
		{
			week_id = Integer.parseInt(form.getFirstValue("week_id"));
		}
		
		if(group_id == -1 || week_id == -1)
		{
			throw new ResourceException(400, "Inputs are not in correct format","");
		}
		
		Student student = ObjectifyService.ofy().load().type(Student.class).parent(Key.create(Guestbook.class, "student")).id(student_id).now();
	  	if(student != null)
	  	{
	  		if(student.group_id == group_id)
	  		{
	  			Attendance attendance = new Attendance(student_id,group_id,week_id,true);
	  			ObjectifyService.ofy().save().entity(attendance).now();
	  		}
	  		else //entered group id is not the same with student's
	  		{
	  			throw new ResourceException(400, "Wrong Group Id","");
	  		}
	  	}
	  	else //there is no student with the given student id
	  	{
  			throw new ResourceException(404, "Invalid Student Id","");
	  	}
	}

	@Get
	public String listAllAttendances()
	{
	    //ObjectifyService.ofy().delete().keys(ObjectifyService.ofy().load().type(Student.class).keys());
	    //ObjectifyService.ofy().delete().keys(ObjectifyService.ofy().load().type(Attendance.class).keys());


		List<Attendance> attendanceList;
		int listingLimit = (getQuery().getValues("show_count")==null?0:Integer.parseInt(getQuery().getValues("show_count")));

		StringBuilder sb = new StringBuilder();
		sb.append("Attendances");

		if(getQuery().getValues("show_group_id") != null)
		{
			String filterByGroup = getQuery().getValues("show_group_id");
			sb.append(" of Group "+filterByGroup+"\n\n");
			attendanceList = ObjectifyService.ofy()
	    	          .load()
	    	          .type(Attendance.class)
	    	          .ancestor(Key.create(Guestbook.class, "attendance"))
	    	          .filter("tutorial_group_id", Integer.parseInt(filterByGroup))
	    	          .order("-date")
	    	          .limit(listingLimit)
	    	          .list();
		}
		else
		{
			sb.append("\n\n");
			attendanceList = ObjectifyService.ofy()
	    	          .load()
	    	          .type(Attendance.class)
	    	          .ancestor(Key.create(Guestbook.class, "attendance"))
	    	          .order("-date")
	    	          .limit(listingLimit)
	    	          .list();
		}    	
		

		try
		{
			for (Attendance attendance : attendanceList) 
	    	{
	    		sb.append("attendance_id: ");
	    		sb.append(attendance.id);
	    		sb.append("\nstudent_id: ");
	    		sb.append(attendance.student_id);
	    		sb.append("\ntutorial_group_id: ");
	    		sb.append(attendance.tutorial_group_id);
	    		sb.append("\nweek_id: ");
	    		sb.append(attendance.week_id);
	    		sb.append("\npresented: ");
	    		sb.append(attendance.presented);
	    		sb.append("\ntutorial_info: ");
	    		sb.append(attendance.tutorial_info);
	    		sb.append("\n\n");
	    	}
		}
		catch(Exception e)
		{
			sb.append(e.getMessage());
		}
		

        return sb.toString();
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