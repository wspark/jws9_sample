package utils;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.List;

public class JvmOptions {
	public static void main(String[] args) {
		RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
		List<String> jvmArgs = runtimeMXBean.getInputArguments();
		for (String arg : jvmArgs) {
		    System.out.println(arg);
		}
	}
	
}
