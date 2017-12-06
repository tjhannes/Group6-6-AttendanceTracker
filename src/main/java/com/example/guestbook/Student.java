package com.example.guestbook;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

import java.lang.String;
import java.util.Date;

/**
 * The @Entity tells Objectify about our entity.  We also register it in {@link OfyHelper}
 * Our primary key @Id is set automatically by the Google Datastore for us.
 *
 * We add a @Parent to tell the object about its ancestor. We are doing this to support many
 * guestbooks.  Objectify, unlike the AppEngine library requires that you specify the fields you
 * want to index using @Index.  Only indexing the fields you need can lead to substantial gains in
 * performance -- though if not indexing your data from the start will require indexing it later.
 *
 * NOTE - all the properties are PUBLIC so that we can keep the code simple.
 **/
@Entity
public class Student {
  @Parent Key<Guestbook> theClass;

  public String student_email;
  @Id public String student_id;
  public int group_id;
  @Index public Date date;
  public String[] attendanceTokens;
  
  /**
   * Simple constructor just sets the date
   **/
  public Student() 
  {
    date = new Date();
  }

  /**
   * A convenience constructor
   **/
  public Student(int group_id) 
  {
    this();
    theClass = Key.create(Guestbook.class, "student");
    this.group_id = group_id;
    
    
  }

  /**
   * Takes all important fields
   **/
  public Student(int group_id, String id, String email) 
  {
    this(group_id);
    student_email = email;
    student_id = id;
  }
  
  public void setAttendanceTokens()
  {
	  RandomStringGenerator stringGen = new RandomStringGenerator();
	  attendanceTokens = new String[13];
	  for(int i=0;i<13;i++)
	  {
		  attendanceTokens[i] = stringGen.nextString();
		  for(int j = 0; j < i; j++)
		  {
			  if(j==i)
				  continue;
			  if(attendanceTokens[i].compareTo(attendanceTokens[j]) == 0)
			  {
				  attendanceTokens[i] = stringGen.nextString();
				  j=0;
			  }
		  }
	  }
	  for(int i=0;i<13;i++)
	  {
		  attendanceTokens[i] += this.student_id;
	  }
  }

}
//[END all]
