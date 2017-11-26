package com.example.guestbook;

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
		String allAttendances = "Attendances\n\n";
	
		int listingLimit = (getQuery().getValues("show_count")==null?0:Integer.parseInt(getQuery().getValues("show_count")));
		String filterByGroup = getQuery().getValues("show_group_id");
		List<Attendance> attendanceList;
		if(filterByGroup != null)
		{
			attendanceList = ObjectifyService.ofy()
	    	          .load()
	    	          .type(Attendance.class)
	    	          .ancestor(Key.create(Attendance.class, "attendance"))
	    	          .filter("tutorial_group_id", Integer.parseInt(filterByGroup))
	    	          .order("-date")
	    	          .limit(listingLimit)
	    	          .list();
		}
		else
		{
			attendanceList = ObjectifyService.ofy()
	    	          .load()
	    	          .type(Attendance.class)
	    	          .ancestor(Key.create(Attendance.class, "attendance"))
	    	          .order("-date")
	    	          .limit(listingLimit)
	    	          .list();
		}    	

    	for (ListIterator<Attendance> iter = attendanceList.listIterator(); iter.hasNext(); ) 
    	{
    	    Attendance element = iter.next();
    	    allAttendances += "attendance_id: " + element.id + "\n";
    	    allAttendances += "student_id: " + element.student_id + "\n";
    	    allAttendances += "tutorial_group_id: " + element.tutorial_group_id + "\n";
    	    allAttendances += "week_id: " + element.week_id + "\n";
    	    allAttendances += "presented: " + element.presented + "\n";
    	    allAttendances += "tutorial_info: " + element.tutorial_info + "\n\n";
    	}

        return allAttendances;
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