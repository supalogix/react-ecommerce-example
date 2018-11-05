import React from 'react';

import { storiesOf } from '@storybook/react';

import * as Stub from "../stubs"
import {createApp} from "../tools"

storiesOf('Stubs', module)
  .add('stub1', () => createApp(Stub.stub1))
  .add('stub2', () => createApp(Stub.stub2))