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
  public int group;
  @Index public Date date;
  
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
  public Student(int group) 
  {
    this();
    theClass = Key.create(Guestbook.class, "student");
    this.group = group;
  }

  /**
   * Takes all important fields
   **/
  public Student(int group, String id, String email) 
  {
    this(group);
    student_email = email;
    student_id = id;
  }

}
//[END all]
