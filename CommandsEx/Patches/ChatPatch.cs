using GDWeave.Godot;
using GDWeave.Godot.Variants;
using GDWeave.Modding;

namespace CommandsEx.Patches;

public class ChatPatch : IScriptMod
{
    public bool ShouldRun(string path) => path == "res://Scenes/HUD/playerhud.gdc";

    public IEnumerable<Token> Modify(string path, IEnumerable<Token> tokens)
    {
        // if text.replace(" ", "") == "": return 
        var waiter_chat = new MultiTokenWaiter([
            t => t.Type is TokenType.CfIf,
            t => t is IdentifierToken{Name:"text"},
            t => t.Type is TokenType.Period,
            t => t is IdentifierToken{Name:"replace"},
            t => t.Type is TokenType.ParenthesisOpen,
            t => t is ConstantToken{Value:StringVariant { Value:" " }},
            t => t.Type is TokenType.Comma,
            t => t is ConstantToken{Value:StringVariant { Value:"" }},
            t => t.Type is TokenType.ParenthesisClose,
            t => t.Type is TokenType.OpEqual,
            t => t is ConstantToken{Value:StringVariant { Value:"" }},
            t => t.Type is TokenType.Colon,
            t => t.Type is TokenType.CfReturn,
            t => t.Type is TokenType.Newline
        ], allowPartialMatch: false);
        
        foreach (var token in tokens)
        {
            if (waiter_chat.Check(token))
            {
                yield return token;
                
                // if text.begins_with("/"):
                yield return new Token(TokenType.CfIf);
                yield return new IdentifierToken("text");
                yield return new Token(TokenType.Period);
                yield return new IdentifierToken("begins_with");
                yield return new Token(TokenType.ParenthesisOpen);
                yield return new ConstantToken(new StringVariant("/"));
                yield return new Token(TokenType.ParenthesisClose);
                yield return new Token(TokenType.Colon);
                
                yield return new Token(TokenType.Newline, 2);
                    // get_node("/root/CommandsEx").handle_command(text)
                    yield return new IdentifierToken("get_node");
                    yield return new Token(TokenType.ParenthesisOpen);
                    yield return new ConstantToken(new StringVariant("/root/CommandsEx"));
                    yield return new Token(TokenType.ParenthesisClose);
                    yield return new Token(TokenType.Period);
                    yield return new IdentifierToken("handle_command");
                    yield return new Token(TokenType.ParenthesisOpen);
                    yield return new IdentifierToken("text");
                    yield return new Token(TokenType.ParenthesisClose);
                    yield return new Token(TokenType.Newline, 2);
                    // return
                    yield return new Token(TokenType.CfReturn);
                    yield return new Token(TokenType.Newline, 1);
            }
            else yield return token;
        }
    }
}