package net.cryp7.range.hello;

import java.io.File;

public class NativeOutput 
{
	public NativeOutput()
	{
		int meaning = 42;
		output();
		
	} /* end default c-tor */
	
	private native int output();

	static
	{
		try
		{
			System.loadLibrary("liboutput.so");
			System.loadLibrary("liboutput-jni.so");
		}
		catch (UnsatisfiedLinkError e)
		{
			try
			{
				System.loadLibrary("liboutput_d.so");
				System.loadLibrary("liboutput-jni_d.so");
			}
			catch (UnsatisfiedLinkError ex)
			{
				File pwd = new File(".");

				try
				{
					System.load(pwd.getAbsoluteFile() + "/liboutput.so");
					System.load(pwd.getAbsoluteFile() + "/liboutput-jni.so");
				}
				catch (UnsatisfiedLinkError exc)
				{
					try
					{
						System.load(pwd.getAbsoluteFile() + "/liboutput_d.so");
						System.load(pwd.getAbsoluteFile() + "/liboutput-jni_d.so");
					}
					catch (UnsatisfiedLinkError exce)
					{
						try
						{
							System.load(pwd.getAbsolutePath() + "/../lib/liboutput.so");
							System.load(pwd.getAbsolutePath() + "/../lib/liboutput-jni.so");
						}
						catch (UnsatisfiedLinkError excep)
						{
							try
							{
								System.load(pwd.getAbsolutePath() + "/../lib/liboutput_d.so");
								System.load(pwd.getAbsolutePath() + "/../lib/liboutput-jni_d.so");
							}
							catch (UnsatisfiedLinkError except)
							{
								try
								{
									System.load(pwd.getAbsolutePath() + "/../build/cmake/build-vc8/artifacts/debug/liboutput_d.so");
									System.load(pwd.getAbsolutePath() + "/../build/cmake/build-vc8/artifacts/debug/liboutput-jni_d.so");
								}
								catch (UnsatisfiedLinkError excepti)
								{
									try
									{
										System.load(pwd.getAbsolutePath() + "/build-ci/artifacts/release/liboutput.so");
										System.load(pwd.getAbsolutePath() + "/build-ci/artifacts/release/liboutput-jni.so");
									}
									catch (UnsatisfiedLinkError exceptio)
									{
										System.load(pwd.getAbsolutePath() + "/build-ci/artifacts/liboutput.so");
										System.load(pwd.getAbsolutePath() + "/build-ci/artifacts/liboutput-jni.so");
									}
								}
							}
						}
					}
				}
			}
		}
	} /* end static */

} /* end class NativeOutput */

/* EOF */
