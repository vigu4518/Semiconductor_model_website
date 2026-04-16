package com.example.website.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import org.springframework.beans.factory.annotation.Value;
import java.util.*;

@Controller
public class HomeCotroller {   // matches file name

    @Value("${prediction.api.url}")
    private String predictionApiUrl;

    @RequestMapping("/")
    public String home() {
        return "index";
    }

    @RequestMapping("/process")
    public String process(
            @RequestParam("type") String type,
            @RequestParam("p1") String p1,
            @RequestParam("p2") String p2,
            @RequestParam(value = "p3", required = false) String p3,
            org.springframework.ui.Model model) {

        // Create RestTemplate
        RestTemplate restTemplate = new RestTemplate();

        // Prepare request data
        Map<String, String> request = new HashMap<>();
        request.put("type", type);
        request.put("p1", p1);
        request.put("p2", p2);

        if ("3".equals(type)) {
            request.put("p3", p3);
        }

        // Set headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Combine request + headers
        HttpEntity<Map<String, String>> entity =
                new HttpEntity<>(request, headers);

        // Call Flask API
        ResponseEntity<Map> response =
                restTemplate.postForEntity(predictionApiUrl, entity, Map.class);

        // Send result to JSP
        model.addAttribute("result", response.getBody().get("result"));

        return "index";
    }
}
