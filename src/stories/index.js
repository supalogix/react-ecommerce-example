import React from 'react';

import { storiesOf } from '@storybook/react';

import * as Stub from "../stubs"
import {createApp} from "../tools"
import Enumerable from "linq"

const stubNames = Enumerable
  .range(1,15)
  .select((value) => `stub${value}` )

const stories = storiesOf('Stubs', module)

stubNames.forEach(stubName => stories.add(
  stubName, 
  () => createApp(Stub[stubName])))