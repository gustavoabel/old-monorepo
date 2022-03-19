import React from 'react';
import { useState, useEffect } from 'react';

import { TextArea, TextInputTextAreaProps, useTranslation } from '@sms/plasma-ui';

import { Container } from './styles';

interface CounterCharacterProps extends TextInputTextAreaProps {
  description?: string;
}

const CounterCharacter: React.FC<CounterCharacterProps> = ({
  description,
  name,
  maxLength = 200,
  label = 'app.forms.description',
  required = false,
  ...rest
}) => {
  const { t } = useTranslation();
  const [text, setText] = useState<string>('');
  const [charLeft, setCharLeft] = useState(maxLength);
  useEffect(() => {
    if (description) {
      setCharLeft(maxLength - (description.length ? description.length : 0));
    } else {
      setCharLeft(maxLength);
    }
  }, [description]);
  return (
    <Container>
      <TextArea
        onChange={(ev) => {
          setText(ev.target.value);
          setCharLeft(maxLength - ev.target.value.length);
        }}
        value={text}
        label={label}
        name={name}
        required={required}
        maxLength={maxLength}
        {...rest}
      />
      <p>
        {' '}
        {charLeft} {t('app.forms.characterCounter')}{' '}
      </p>
    </Container>
  );
};

export default CounterCharacter;
