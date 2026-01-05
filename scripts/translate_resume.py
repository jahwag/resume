import openai
import os

def translate_text(text, client):
    response = client.responses.create(
        model='gpt-5-mini',
        input=text,
        instructions=r'''You are a professional Swedish translator. Translate the LaTeX content to fluent, grammatically correct Swedish.

Rules:
- Use proper Swedish vocabulary (e.g., "seniorutvecklare" not "seniordelare", "tjänstgjorde" not "änstgjorde")
- Keep all LaTeX commands and formatting unchanged
- Keep technology names, company names, and certifications in English
- Escape & as \&
- Output only raw LaTeX, no markdown''',
        reasoning={
            'effort': 'medium',
            'summary': 'auto'
        }
    )
    return response.output_text.strip()

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
