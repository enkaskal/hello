package net.cryp7.range.hello;

import java.io.File;

public class NativeOutput 
{
	public NativeOutput()
	{
		output();
		
	} /* end default c-tor */
	
	private native int output();

	static
	{
		String os = System.getProperty("os.name").toUpperCase();
		if ( os.startsWith("WIN") )
		{
			try
			{
				System.loadLibrary("output");
				System.loadLibrary("output-jni");
			}
			catch (UnsatisfiedLinkError e)
			{
				File pwd = new File(".");
				
				try
				{
					System.load(pwd.getAbsoluteFile() + "/output.dll");
					System.load(pwd.getAbsoluteFile() + "/output-jni.dll");
				}
				catch (UnsatisfiedLinkError ex)
				{
					try
					{
						System.load(pwd.getAbsoluteFile() + "/output_d.dll");
						System.load(pwd.getAbsoluteFile() + "/output-jni_d.dll");
					}
					catch (UnsatisfiedLinkError exc)
					{
						try
						{
							System.load(pwd.getAbsoluteFile() + "/../lib/output.dll");
							System.load(pwd.getAbsoluteFile() + "/../lib/output-jni.dll");
						}
						catch (UnsatisfiedLinkError exce)
						{
							try
							{
								System.load(pwd.getAbsoluteFile() + "/../lib/output_d.dll");
								System.load(pwd.getAbsoluteFile() + "/../lib/output_d-jni.dll");
							}
							catch (UnsatisfiedLinkError excep)
							{
								try
								{
									System.load(pwd.getAbsoluteFile() + "/../build/cmake/build-vc8/artifacts/debug/output_d.dll");
									System.load(pwd.getAbsoluteFile() + "/../build/cmake/build-vc8/artifacts/debug/output-jni_d.dll");
								}
								catch (UnsatisfiedLinkError except)
								{
									System.out.println("attempting final load: " + pwd.getAbsoluteFile() + "/../build-ci/artifacts/release/");
									System.load(pwd.getAbsoluteFile() + "/build-ci/artifacts/release/output.dll");
									System.load(pwd.getAbsoluteFile() + "/build-ci/artifacts/release/output-jni.dll");
								}
							}
						}
					}
				}
			}
		}
		else
		{
			try
			{
				System.loadLibrary("output");
				System.loadLibrary("output-jni");
			}
			catch (UnsatisfiedLinkError e)
			{
				File pwd = new File(".");
				
				try
				{
					System.load(pwd.getAbsoluteFile() + "/liboutput.so");
					System.load(pwd.getAbsoluteFile() + "/liboutput-jni.so");
				}
				catch (UnsatisfiedLinkError ex)
				{
					try
					{
						System.load(pwd.getAbsoluteFile() + "/liboutput_d.so");
						System.load(pwd.getAbsoluteFile() + "/liboutput-jni_d.so");
					}
					catch (UnsatisfiedLinkError exc)
					{
						try
						{
							System.load(pwd.getAbsoluteFile() + "/../lib/liboutput.so");
							System.load(pwd.getAbsoluteFile() + "/../lib/liboutput-jni.so");
						}
						catch (UnsatisfiedLinkError exce)
						{
							try
							{
								System.load(pwd.getAbsoluteFile() + "/../lib/liboutput_d.so");
								System.load(pwd.getAbsoluteFile() + "/../lib/liboutput_d-jni.so");
							}
							catch (UnsatisfiedLinkError excep)
							{
								System.load(pwd.getAbsoluteFile() + "/build-ci/artifacts/liboutput.so");
								System.load(pwd.getAbsoluteFile() + "/build-ci/artifacts/liboutput-jni.so");
							}
						}
					}
				}
			}
		}
	} /* end static */

} /* end class NativeOutput */

/* EOF */
