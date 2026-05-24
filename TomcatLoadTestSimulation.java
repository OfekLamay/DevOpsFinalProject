package computerdatabase;

import static io.gatling.javaapi.core.CoreDsl.*;
import static io.gatling.javaapi.http.HttpDsl.*;

import io.gatling.javaapi.core.*;
import io.gatling.javaapi.http.*;

public class TomcatLoadTestSimulation extends Simulation {

    HttpProtocolBuilder httpProtocol = http
            .baseUrl("http://165.245.208.238:8080")
            .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
            .acceptLanguageHeader("he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7")
            .acceptEncodingHeader("gzip, deflate")
            .userAgentHeader("Mozilla/5.0 (Windows NT 10.0; Win64; x64) Gatling/LoadTest");

    ScenarioBuilder scn = scenario("Hit DevOps Landing Page (Load Test)")
            .exec(http("Load Index JSP")
                    .get("/OfekLamay_BenLetai_LinoyAvraham_TomerBiton_AmitHazan/index.jsp")
                    .check(status().is(200))
            );

    {
        setUp(
            scn.injectOpen(
                // 30 שניות של חימום: עליה מ-0 ל-90 משתמשים בשנייה
                rampUsersPerSec(0).to(90).during(30),
                
                // 270 שניות (4.5 דקות): עומס קבוע של 90 משתמשים בשנייה
                constantUsersPerSec(90).during(270)
            )
        ).protocols(httpProtocol);
    }
}