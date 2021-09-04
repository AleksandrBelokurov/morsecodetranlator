#include "translator.h"

Translator::Translator(QObject *parent) : QObject(parent)
{
    QMap<QString, QString>::const_iterator it = letters2Morse_.cbegin();
    while (it != letters2Morse_.cend())
    {
        morse2Letters_.insert(it.value(), it.key());
        ++it;
    }
}

QString Translator::encodeMorse(const QString &text)
{
    QStringList sl;
    QString answer;
    sl = text.split(" ");
    foreach (auto token, sl)
    {
        if (!token.isEmpty())
            answer += encodeToken(token) + "  ";
    }
    return answer.trimmed();
}

QString Translator::decodeMorse(const QString &text)
{
    QStringList sl;
    QStringList slt;
    QString answer;
    sl = text.split("  ");
    foreach (auto str, sl)
    {
        slt = str.split(" ");
        if (!str.isEmpty())
        {
            foreach (auto token, slt)
            {
                if (!token.isEmpty())
                    answer += decodeToken(token);
            }
        answer += " ";
        }
    }
    return answer.trimmed();
}

QString Translator::encodeToken(const QString &token)
{
    QString morseWord = "";
    for (int i = 0; i < token.length(); i++)
    {
        QMap<QString, QString>::const_iterator it =
                letters2Morse_.constFind(QString(token[i].toUpper().toLatin1()));
        if (it != letters2Morse_.cend())
            morseWord += it.value() + " ";
    }
    return morseWord.trimmed();
}

QString Translator::decodeToken(const QString &token)
{
    QMap<QString, QString>::iterator it =
            morse2Letters_.find(token);
    if (it != morse2Letters_.end())
        return it.value();
    return QString();
}
