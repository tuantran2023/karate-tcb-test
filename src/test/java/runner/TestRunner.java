package runner;

import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate runTest() {
        return Karate.run("classpath:features/order.feature");
    }
}
