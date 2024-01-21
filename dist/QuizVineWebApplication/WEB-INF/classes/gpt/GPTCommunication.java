/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package gpt;

import config.EnvironmentConfiguration;
import db.AnswerDAO;
import db.QuestionDAO;
import db.User;
import db.UserChoice;
import db.UserChoiceDAO;
import db.UserWinePreference;
import db.Wine;
import db.WineDAO;
import db.WinePreferenceDAO;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class GPTCommunication {
    private final String apiEndPoint = "https://api.openai.com/v1/chat/completions";
    private final String systemPrompt 
            = "You are a helpful assistant. The only answers you can provide are comma separated lists of numbers.";
    private final String userPromptTemplate 
            = "Suppose you're given the following wine list: {{wineList}}. Pick the top 5 wines for a person who {{preference}}. Your answer must contain ONLY the wine IDs, in the order you chose them, separated by commas.";
    
    public void generateUserPreferences(User user) throws Exception {
        String gptResponse = executeWebRequest(user);
        handleResponse(user, gptResponse);
    }
    
    private String executeWebRequest(User user) throws Exception {
        URL url = new URL(apiEndPoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(30000);
        
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json;charset=utf-8");

        conn.setRequestProperty("Accept", "application/json");
        conn.setDoOutput(true);
        
        conn.setRequestProperty("Authorization", "Bearer " + EnvironmentConfiguration.GPT_API_KEY);
        
        String payload = buildPayload(user);
        Logger.getLogger(GPTCommunication.class.getName()).log(Level.SEVERE, payload, payload);

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = payload.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        } catch (Exception e) {
            e.printStackTrace();
        }
        int responseCode = conn.getResponseCode();
        if (responseCode != 200) {
            throw new Exception("Bad Handling of gpt");
        }
        
        InputStream inputStream = null;
        StringBuilder response = new StringBuilder();
        String line = null;
        try {
            inputStream = conn.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            while ((line = bufferedReader.readLine()) != null) {
                response.append(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            conn.disconnect();
        }
        return response.toString();
    }
    
    private String buildPayload(User user) throws Exception {
        JSONObject payload = new JSONObject();
        payload.put("model", EnvironmentConfiguration.GPT_MODEL);
        
        JSONArray messages = new JSONArray(); 
        
        JSONObject systemMessage = new JSONObject();
        systemMessage.put("role", "system");
        systemMessage.put("content", systemPrompt);
        messages.add(systemMessage);
        
        JSONObject userMessage = new JSONObject(); 
        userMessage.put("role", "user");
        userMessage.put("content", userPromptTemplate.replace("{{wineList}}", getWineListJsonString()).replace("{{preference}}", getUserPreferencesAsPrompt(user)));
        messages.add(userMessage);
        
        payload.put("messages", messages);
        
        return payload.toJSONString();
    };
    
    private void handleResponse(User user, String response) throws Exception {
        JSONParser parser = new JSONParser();
        JSONObject json = (JSONObject) parser.parse(response);
        JSONArray choices = (JSONArray) json.get("choices");
        JSONObject firstChoice = (JSONObject) choices.get(0);
        JSONObject message = (JSONObject) firstChoice.get("message");
        String content = (String) message.get("content");
        content = content.replaceAll("\\s", "");
        String[] ids = content.split(",");
        int order = 1;
        WinePreferenceDAO winePreferenceDao = new WinePreferenceDAO();
        for(String id: ids) {
            int actualId = Integer.parseInt(id);
            winePreferenceDao.insertWinePreference(new UserWinePreference(user.getId(), actualId, order));
            ++order;
        }
    }
    
    private String getWineListJsonString() throws Exception {
        WineDAO wineDao = new WineDAO(); 
        ArrayList<Wine> wines = wineDao.getAllWines();
        JSONArray winesJsonArray = new JSONArray(); 
        for (Wine wine: wines) {
            JSONObject wineObject = new JSONObject();
            wineObject.put("ID", wine.getId());
            wineObject.put("Name", wine.getName());
            winesJsonArray.add(wineObject);
        }
        return winesJsonArray.toJSONString();
    }
    
    private String getUserPreferencesAsPrompt(User user) throws Exception {
        String prompt = "";
        UserChoiceDAO userChoiceDao = new UserChoiceDAO();
        QuestionDAO questionDao = new QuestionDAO(); 
        AnswerDAO answerDao = new AnswerDAO();
        
        ArrayList<UserChoice> choices = userChoiceDao.getUserChoices(user); 
        for (UserChoice choice: choices) {
            String questionPrompt = questionDao.getQuestionPrompt(choice.getQuestionId());
            String answerPrompt = answerDao.getAnswerPrompt(choice.getAnswerId());
            String otherAnswersPrompt = answerDao.getOtherAnswersPrompt(choice.getAnswerId(), choice.getQuestionId());
            if (prompt.length() > 0) {
                prompt += " and ";
            }
            prompt += questionPrompt.replace("{{answer}}", answerPrompt).replace("{{otheranswers}}", otherAnswersPrompt);
            
        }
        return prompt;
    }
    
    
    
}
