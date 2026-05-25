import java.time.Duration;
import java.util.*;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;
import io.gatling.javaapi.jdbc.*;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;
import static io.gatling.javaapi.jdbc.JdbcDsl.*;

public class Load extends Simulation {

  private HttpProtocolBuilder httpProtocol = http
    .baseUrl("http://165.245.208.238:8080")
    .inferHtmlResources(AllowList(), DenyList(".*\\.js", ".*\\.css", ".*\\.gif", ".*\\.jpeg", ".*\\.jpg", ".*\\.ico", ".*\\.woff", ".*\\.woff2", ".*\\.(t|o)tf", ".*\\.png", ".*\\.svg", ".*detectportal\\.firefox\\.com.*"))
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7")
    .acceptEncodingHeader("gzip, deflate")
    .acceptLanguageHeader("he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7")
    .upgradeInsecureRequestsHeader("1")
    .userAgentHeader("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36");
  
  private Map<CharSequence, String> headers_0 = Map.ofEntries(
    Map.entry("Cache-Control", "max-age=0"),
    Map.entry("Origin", "http://165.245.208.238:8080")
  );

  private ScenarioBuilder scn = scenario("Load")
    .exec(
      http("request_0")
        .post("/OfekLamay_BenLetai_LinoyAvraham_TomerBiton_AmitHazan/index.jsp?taskData=%D7%A1%D7%A9%D7%93%D7%92%D7%A9%D7%93%D7%92")
        .headers(headers_0)
        .formParam("expenseName", "שרת")
        .formParam("amount", "65")
    );

  {
    setUp(
      scn.injectOpen(
			rampUsersPerSec(10).to(110).during(Duration.ofMinutes(1)),                   
      
			constantUsersPerSec(110).during(Duration.ofMinutes(3)),
                   
			rampUsersPerSec(110).to(10).during(Duration.ofMinutes(1))
      )
    ).protocols(httpProtocol);
  }
}