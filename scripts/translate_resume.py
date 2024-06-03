import openai
import os

def translate_text(text, client):
    response = client.chat.completions.create(
        model='gpt-4o',
        messages=[
            {'role': 'system', 'content': r'You are a translator. Translate the following LaTeX content to Swedish. Only translate the text content, do not translate commands or formatting. Remember that the character & has to be escaped as \&.'},
            {'role': 'user', 'content': text}
        ],
    )
    return response.choices[0].message.content.strip()

def main():
    api_key = os.getenv('OPENAI_API_KEY')
    client = openai.OpenAI(api_key=api_key)

    with open('resume.tex', 'r') as file:
        english_text = file.read()

    swedish_text = translate_text(english_text, client)

    with open('resume-sve.tex', 'w') as file:
        file.write(swedish_text)

if __name__ == "__main__":
    main()
