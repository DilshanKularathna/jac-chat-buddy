import:py from jaclang.core.llms, Anthropic; # can use any llm Ex:- Openai, Ollama
# Anthropic is not working because i had a problem with the api key i got my api key but it says my credit balance is low

glob llm = Anthropic(model_name= "claude-3-sonnet-20240229");

can 'Translate an Engilsh text to a given language'
translate(input :'Input phrase in English' :str, lan :'Output language' :str = "French") -> 'Translate Output Phrase' :str by llm(); # 'description' in front of every thing call the sem string

with entry {
    print(translate("I am Batman", "French"));
    print(translate("I am Batman", "Spanish"));
}