package egovframework.platform.module.common;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class DefaultRestTemplate extends RestTemplate {
	public DefaultRestTemplate() {
		super();
	}
}
