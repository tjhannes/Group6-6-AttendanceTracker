package com.example.guestbook;

import java.util.Random;

public class RandomStringGenerator 
{
	Random random;
	String characters = "ABCDEFGHIJKLMNOPQRSTUWVYZabcdefghijklmnopqrstuwvyz0123456789";
	
	public RandomStringGenerator()
	{
		random = new Random();
	}
	
	public String nextString(int length)
	{
		String randomString = "";
		int arrLength = characters.length();
		for(int i=0;i<length;i++)
		{
			randomString += characters.charAt(random.nextInt(arrLength));
		}
		return randomString;
	}
	
	public String nextString()
	{
		return nextString(20);
	}
}
